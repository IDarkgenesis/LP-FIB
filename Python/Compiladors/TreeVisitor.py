if __name__ is not None and "." in __name__:
    from .ExprParser import ExprParser
    from .ExprVisitor import ExprVisitor
else:
    from ExprParser import ExprParser
    from ExprVisitor import ExprVisitor
class TreeVisitor(ExprVisitor):
    def __init__(self):
        self.nivell = 0
    def visitExpr(self, ctx:ExprParser.ExprContext):
        if ctx.getChildCount() == 1:
            n = next(ctx.getChildren())
            print("  " * self.nivell +
                  ExprParser.symbolicNames[n.getSymbol().type] +
                  '(' +n.getText() + ')')
            self.nivell -= 1
        elif ctx.getChildCount() == 3:
            op= 'NOT DEFINED IN TreeVisitor.py'
            if ctx.MES():
                op= 'MES(+)'
            elif ctx.DIV():
                op= 'DIV(/)'
            elif ctx.MUL():
                op= 'MUL(*)'
            elif ctx.MENYS():
                op= 'MENYS(-)'
            elif ctx.POW():
                op= 'POW(^)'
    
            print('  ' *  self.nivell + op)
            self.nivell += 1
            self.visit(ctx.expr(0))
            self.nivell += 1
            self.visit(ctx.expr(1))
            self.nivell -= 1
