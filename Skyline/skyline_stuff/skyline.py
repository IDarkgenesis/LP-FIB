import matplotlib.pyplot as plt
import matplotlib
import random
import copy


def findpos(elems, xm, left, right):
    # print(left,right)
    if left <= right:
        p = (left + right) // 2
        if xm == elems[p].xmin:
            return p
        elif xm < elems[p].xmin:
            return findpos(elems, xm, left, p - 1)
        else:
            return findpos(elems, xm, p + 1, right)
    else:
        return left


class Building:
    def __init__(self, xm, y, xmx, ovlp):
        self.xmin = xm
        self.xmax = xmx
        self.y = y
        self.overlaped = ovlp
        self.area = abs(self.xmax - self.xmin) * (self.y - self.overlaped)

    def __str__(self):
        return "Building(%d,%d,%d) -> Area: %d" % (self.xmin, self.y, self.xmax, self.area)

    def getarea(self):
        return self.area

    def renewarea(self):
        self.area = abs(self.xmax - self.xmin) * (self.y - self.overlaped)

    def duplicate(self, n, long):
        return Building(self.xmin + long * n, self.y, self.xmax + long * n, self.overlaped)


class Skyline:

    def __init__(self, skyline=None):
        if skyline is None:
            self.buildings = []
            self.area = 0
            self.hei = 0
        else:
            self.buildings = copy.deepcopy(skyline.buildings)
            self.area = copy.deepcopy(skyline.area)
            self.hei = copy.deepcopy(skyline.hei)

    def addbuilding(self, b):
        if len(self.buildings) == 0:
            self.buildings.append(b)
            self.area += self.buildings[0].getarea()
            self.hei = self.buildings[0].y
        else:
            newp = findpos(self.buildings, b.xmin, 0, len(self.buildings) - 1)
            self.buildings.insert(newp, b)
            self.area += self.buildings[newp].getarea()
            self.hei = self.buildings[newp].y

            i = newp + 1
            while i < len(self.buildings) and self.buildings[i].xmin <= b.xmax:
                if self.buildings[i].xmax <= b.xmax:
                    if self.buildings[i].y <= b.y:
                        self.area -= self.buildings[i].getarea()
                        self.buildings.pop(i)
                        continue
                    else:
                        self.buildings[i].overlaped = abs(b.y - self.buildings[i].y)
                        self.area -= self.buildings[i].getarea()
                        self.buildings[i].renewarea()
                        self.area += self.buildings[i].getarea()
                        if self.hei < self.buildings[i].y:
                            self.hei = self.buildings[i].y
                else:
                    diff = b.xmax - self.buildings[i].xmin
                    self.buildings[i].xmin += diff
                    self.area -= self.buildings[i].getarea()
                    self.buildings[i].renewarea()
                    self.area += self.buildings[i].getarea()
                    if self.hei < self.buildings[i].y:
                        self.hei = self.buildings[i].y
                i += 1

    def rngcreator(self, n, h, w, xmin, xmax):
        for i in range(0, n):
            he = random.randrange(0, h, 1)
            wi = random.randrange(1, w, 1)
            xm = random.randrange(xmin, xmax)

            while xm + wi > xmax:
                xm = random.randrange(xmin, xmax)

            self.addbuilding(Building(xm, he, xm + wi, 0))
        self.calcArea()

    def translate(self, n):
        for elem in self.buildings:
            elem.xmin += n
            elem.xmax += n

    def union(self, sk):
        auxBuild = copy.deepcopy(sk.buildings)
        for elem in auxBuild:
            self.addbuilding(elem)
        self.calcArea()

    def intersection(self, sk):
        if len(self.buildings) > 0:
            auxBuild = copy.deepcopy(sk.buildings)
            auxSky = Skyline()
            for elem in auxBuild:
                pos = findpos(self.buildings, elem.xmin, 0, len(self.buildings) - 1)
                # print(pos)
                if pos < len(self.buildings) and elem.xmin >= self.buildings[pos].xmin and elem.xmax <= self.buildings[pos].xmax and elem.y <= self.buildings[pos].y:
                    auxSky.addbuilding(elem)
            self.buildings = copy.deepcopy(auxSky.buildings)
            self.calcArea()

    def replicate(self, n):
        if len(self.buildings) > 0 and n > 1:
            cpy = self.buildings.copy()
            dist = abs(self.buildings[len(self.buildings) - 1].xmax - self.buildings[0].xmin)
            for it in range(1, n):
                for elem in cpy:
                    self.buildings.append(elem.duplicate(it, dist))
            self.calcArea()

    def reversebuildings(self):
        if len(self.buildings) > 0:
            lng = self.buildings[len(self.buildings) - 1].xmax

            for elem in self.buildings:
                d1 = lng - elem.xmin
                d2 = lng - elem.xmax

                elem.xmin += d1 * 2 - lng
                elem.xmax += d2 * 2 - lng
            self.buildings.reverse()
            self.calcArea()

    def createplot(self, path):
        fig, ax = plt.subplots()
        pos = [elem.xmin for elem in self.buildings]
        ys = [elem.y for elem in self.buildings]
        wi = [elem.xmax - elem.xmin for elem in self.buildings]

        ax.bar(pos, ys, wi, align='edge', facecolor='#ff0000')
        matplotlib.pyplot.savefig(path)

    def calcArea(self):
        self.area = 0
        self.hei = 0
        for elem in self.buildings:
            self.area += elem.getarea()
            if self.hei < elem.y:
                self.hei = elem.y

"""""
random.seed()
sk1 = Skyline()
sk2 = Skyline()

start = time.time()
sk1.rngcreator(100000, 20, 3, 1, 10000)
end = time.time()
print(end - start)

start = time.time()
sk1.reversebuildings()
end = time.time()
print(end - start)

for x in sk1.buildings:
    print(x)

sk1.createplot(sk1)

# Skyline.createplot(sk1)

start = time.time()
end = time.time()
print(end - start)
"""""
