# Generated from Skyline.g by ANTLR 4.7.2
from antlr4 import *
if __name__ is not None and "." in __name__:
    from .SkylineParser import SkylineParser
else:
    from SkylineParser import SkylineParser

# This class defines a complete generic visitor for a parse tree produced by SkylineParser.

class SkylineVisitor(ParseTreeVisitor):

    # Visit a parse tree produced by SkylineParser#root.
    def visitRoot(self, ctx:SkylineParser.RootContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SkylineParser#let.
    def visitLet(self, ctx:SkylineParser.LetContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SkylineParser#alone.
    def visitAlone(self, ctx:SkylineParser.AloneContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SkylineParser#opskyline.
    def visitOpskyline(self, ctx:SkylineParser.OpskylineContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SkylineParser#parent.
    def visitParent(self, ctx:SkylineParser.ParentContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SkylineParser#intersec.
    def visitIntersec(self, ctx:SkylineParser.IntersecContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SkylineParser#replicate.
    def visitReplicate(self, ctx:SkylineParser.ReplicateContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SkylineParser#union.
    def visitUnion(self, ctx:SkylineParser.UnionContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SkylineParser#transp.
    def visitTransp(self, ctx:SkylineParser.TranspContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SkylineParser#transn.
    def visitTransn(self, ctx:SkylineParser.TransnContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SkylineParser#reflexion.
    def visitReflexion(self, ctx:SkylineParser.ReflexionContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SkylineParser#skln.
    def visitSkln(self, ctx:SkylineParser.SklnContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SkylineParser#simp.
    def visitSimp(self, ctx:SkylineParser.SimpContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SkylineParser#rng.
    def visitRng(self, ctx:SkylineParser.RngContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by SkylineParser#comp.
    def visitComp(self, ctx:SkylineParser.CompContext):
        return self.visitChildren(ctx)



del SkylineParser