if __name__ is not None and "." in __name__:
    from .ExprParser import ExprParser
    from .ExprVisitor import ExprVisitor
else:
    from ExprParser import ExprParser
    from ExprVisitor import ExprVisitor
    
class EvalVisitor(ExprVisitor):
    
    def visitRoot(self, ctx:ExprParser.RootContext):
        n = next(ctx.getChildren())        
        print(self.visit(n))
    
    def visitExpr(self, ctx:ExprParser.ExprContext):
        l = [n for n in ctx.getChildren()]        
        if len(l) == 1:
            return int(l[0].getText())
        elif len(l) == 3:
            if ctx.MES():
                return self.visit(l[0]) + self.visit(l[2])
            elif ctx.MENYS():
                return self.visit(l[0]) - self.visit(l[2])
            elif ctx.MUL():
                return self.visit(l[0]) * self.visit(l[2])
            elif ctx.DIV():
                return self.visit(l[0]) / self.visit(l[2])
            elif ctx.POW():
                return self.visit(l[0]) ** self.visit(l[2])
