class Tree:
    
    def __init__(self, x):
        self.rt=x
        self.child=[]
    
    def __iter__(self):
        queue= [self]
        while queue:
            act=queue.pop(0)
            yield act.rt
            for c in act.child:
                queue.append(c)
    
    def addChild(self, a):
        self.child.append(a)
    
    def root(self):
        return self.rt
 
    def ithChild(self, ith):
        if ith  > len(self.child):
            return
        else:
            return self.child[ith]
         
    def num_children(self):
        return len(self.child)

class Pre(Tree):
    
    def preorder(self):
        aux=[]
        for x in self.child:
            aux += x.preorder()
        return [self.rt] + aux
        

'''
t = Tree(2)
t.addChild(Tree(3))
t.addChild(Tree(4))
t.ithChild(0).addChild(Tree(5))
print([x for x in t])
'''
