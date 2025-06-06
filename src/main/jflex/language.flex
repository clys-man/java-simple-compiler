package com.clysman.compiler;

import com.clysman.compiler.sym;
import java_cup.runtime.*;

%%

%{
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }

    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}


%class scanner
%unicode
%cup
%line
%column

WHITESPACE = [ \t\n\r]+
DIGIT = [0-9]+

%%

<YYINITIAL> {
    {WHITESPACE}  { /**/ }
    ";"           { return symbol(sym.SEMI); }
    "+"           { return symbol(sym.PLUS); }
    "-"           { return symbol(sym.MINUS); }
    "*"           { return symbol(sym.TIMES); }
    "("           { return symbol(sym.LPAREN); }
    ")"           { return symbol(sym.RPAREN); }
    "/"           { return symbol(sym.DIVISION); }
    {DIGIT}       { return symbol(sym.NUMBER, Double.parseDouble(yytext())); }
    .             { System.err.println("Caractere ilegal na linha " + (yyline+1) +
                             ", coluna " + (yycolumn+1) + ": '" + yytext() + "'"); }
}