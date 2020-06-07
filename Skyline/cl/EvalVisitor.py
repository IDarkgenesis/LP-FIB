from skyline_stuff.skyline import Skyline
from skyline_stuff.skyline import Building
import copy

if __name__ is not None and "." in __name__:
    from cl.SkylineParser import SkylineParser
    from cl.SkylineVisitor import SkylineVisitor
else:
    from cl.SkylineParser import SkylineParser
    from cl.SkylineVisitor import SkylineVisitor


class EvalVisitor(SkylineVisitor):
    def __init__(self, Skylines):
        self.Skylines = Skylines

    def visitRoot(self, ctx: SkylineParser.RootContext):
        lst = [n for n in ctx.getChildren()]
        print("visitRoot")
        return self.visit(lst[0])

    def visitLet(self, ctx: SkylineParser.LetContext):
        print("visitLet")
        lst = [n for n in ctx.getChildren()]
        nameVar = lst[0].getText()
        # print("nameVar: " + str(nameVar))
        skln = Skyline(self.visit(lst[2]))
        self.Skylines[nameVar] = skln
        return skln

    def visitAlone(self, ctx: SkylineParser.AloneContext):
        print("visitAlone")
        lst = [n for n in ctx.getChildren()]
        skln = Skyline(self.visit(lst[0]))
        return skln

    def visitOpskyline(self, ctx: SkylineParser.OpskylineContext):
        print("visitOpskyline")
        lst = [n for n in ctx.getChildren()]
        if ctx.parent():
            print("parent")
            skln = Skyline(self.visit(lst[1]))
            return skln

        if ctx.reflexion():
            print("reflexion")
            skln = Skyline(self.visit(lst[1]))
            skln.reversebuildings()
            return skln

        if ctx.intersec():
            print("intersec")
            sk1 = Skyline(self.visit(lst[0]))
            sk2 = Skyline(self.visit(lst[2]))
            sk1.intersection(sk2)
            skln = Skyline(sk1)

            return skln

        if ctx.replicate():
            print("replicate")
            n = int(lst[2].getText())
            skln = Skyline(self.visit(lst[0]))
            skln.replicate(n)

            return skln

        if ctx.union():
            print("union")
            sk1 = Skyline(self.visit(lst[0]))
            sk2 = Skyline(self.visit(lst[2]))
            sk1.union(sk2)
            skln = Skyline(sk1)

            return skln

        if ctx.transp():
            print("transp")
            n = int(lst[2].getText())
            skln = Skyline(self.visit(lst[0]))
            skln.translate(n)

            return skln

        if ctx.transn():
            print("transn")
            n = int(lst[2].getText())
            n *= -1
            skln = Skyline(self.visit(lst[0]))
            skln.translate(n)

            return skln

        if ctx.skln():
            print("Using skyline")
            skln = Skyline(self.visit(lst[0]))
            return skln

        if ctx.simp():
            print("simp")
            skln = Skyline()
            b = copy.deepcopy(self.visit(lst[1]))
            skln.addbuilding(b)

            return skln

        if ctx.rng():
            print("rng")
            skln = Skyline(self.visit(lst[1]))
            return skln

        if ctx.comp():
            print("comp")
            skln = Skyline(self.visit(lst[1]))
            return skln

    def visitSimp(self, ctx: SkylineParser.SimpContext):
        print("visitSimp")
        lst = [n for n in ctx.getChildren()]
        return Building(float(lst[0].getText()), float(lst[2].getText()), float(lst[4].getText()), 0)

    def visitRng(self, ctx: SkylineParser.RngContext):
        print("visitRng")
        lst = [n for n in ctx.getChildren()]
        skln = Skyline()
        skln.rngcreator(int(lst[0].getText()), int(lst[2].getText()), int(lst[4].getText()), int(lst[6].getText()),
                        int(lst[8].getText()))
        return skln

    def visitComp(self, ctx: SkylineParser.CompContext):
        print("visitComp")
        lst = [n for n in ctx.getChildren()]
        skln = Skyline()
        b = copy.deepcopy(self.visit(lst[1]))
        skln.addbuilding(b)
        i = 5
        while i < len(lst):
            b = copy.deepcopy(self.visit(lst[i]))
            skln.addbuilding(b)
            i += 4
        return skln

    def visitSkln(self, ctx: SkylineParser.SklnContext):
        print("I FKNG EXIST (IM RETARD :D)")
        lst = [n for n in ctx.getChildren()]
        nameVar = lst[0].getText()
        return self.Skylines[nameVar]
