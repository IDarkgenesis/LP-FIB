class Tree:
    
    def __init__(self, x):
        self.rt=x
        self.child=[]
         
    def add_child(self, a):
        self.child.append(a)
    
    def root(self):
        return self.rt
 
    def ith_child(self, ith):
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
# Test

t= Pre(2)
t.add_child(Pre(3))
t.add_child(Pre(4))
print(t.num_children())
t.ith_child(1).add_child(Pre(5))
print(t.preorder())

'''
