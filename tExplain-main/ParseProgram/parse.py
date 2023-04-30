from clingo import Control, ast
from typing import cast
from clingo.ast import parse_string, parse_files, AST, ASTType

prog = ["program.lp"]


def check(stm):
    if stm.ast_type == ASTType.Rule:
        print("\n")
        print(stm)
        print("%30s %s" % ("stm:", stm.ast_type))
        print("%30s %s" % ("stm.head:", stm.head.ast_type))
        print("%30s %s" % ("stm.head.atom:", stm.head.atom.ast_type))
        if stm.head.atom.ast_type == ASTType.Comparison:
            print("%30s %s" % ("stm.head.atom.term", stm.head.atom))
            return
        if stm.head.atom.ast_type == ASTType.BooleanConstant:
            print("%30s %s" %
                  ("stm.head.atom.ast_type.value:", stm.head.atom.value))
            return
        print("%30s %s" % ("stm.head.atom.symbol:", stm.head.atom.symbol.ast_type))
        if stm.head.atom.symbol.ast_type == ASTType.UnaryOperation:
            print("%30s %s" % ("stm.head.atom.symbol.argument",
                  stm.head.atom.symbol.argument))
            return
        print("%30s %s" % ("stm.head.atom.symbol.name:", stm.head.atom.symbol.name))
        print("\n")


parse_files(prog, check)


def parse_statement(s: str) -> AST:

    stm = None

    def check(wh):
        nonlocal stm
        stm = wh
        if stm.ast_type == ASTType.Rule:
            if "p" in str(wh):
                print("wh:", wh.ast_type)
                print("wh.head:", wh.head.ast_type)
                print("wh.head.atom:", wh.head.atom.ast_type)
                print("wh.head.atom.symbol:", wh.head.atom.symbol.ast_type)
                print("wh.head.atom.symbol.name:", wh.head.atom.symbol.name)
                print(wh.head.atom.symbol)
                # print(wh.body[0])

    parse_string(s, check)
    return cast(AST, stm)


# print()
a = parse_statement("p(X) :- q(X), r(X).")
print(a.body[0])
