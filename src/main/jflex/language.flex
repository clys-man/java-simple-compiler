package com.clysman.compiler;

import com.clysman.compiler.sym;
import java_cup.runtime.*;

%%

%class scanner
%unicode
%cup
%line
%column

%{
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }

    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}

WHITESPACE = [ \t\r\n]+
DIGIT = [0-9]
LETTER = [a-zA-Z_]
ALPHANUM = [a-zA-Z0-9_]

// Tipos
INTEGER = {DIGIT}+
FLOAT = {DIGIT}+\.{DIGIT}+
STRING_LITERAL = \"([^\\\"\n]|\\.)*\"

// Identificadores
IDENTIFIER = {LETTER}{ALPHANUM}*

// Comentários
SINGLE_LINE_COMMENT = "//".*
MULTI_LINE_COMMENT = "/*"(.|\n)*?"*/"

%%

<YYINITIAL> {
    // Whitespace e newlines
    {WHITESPACE}            { /* ignorar */ }

    // Comentários
    {SINGLE_LINE_COMMENT}   { /* ignorar */ }
    {MULTI_LINE_COMMENT}    { /* ignorar */ }

    // Keywords
    "se"                    { return symbol(sym.IF); }
    "senao"                  { return symbol(sym.ELSE); }
    "enquanto"                 { return symbol(sym.WHILE); }
    "para"                   { return symbol(sym.FOR); }
    "retorne"                { return symbol(sym.RETURN); }
    "cadeia"                { return symbol(sym.STRING_TYPE); }
    "inteiro"                   { return symbol(sym.INT_TYPE); }
    "real"                 { return symbol(sym.FLOAT_TYPE); }
    "logico"                  { return symbol(sym.BOOL_TYPE); }
    "VERDADEIRO"                  { return symbol(sym.TRUE); }
    "FALSO"                 { return symbol(sym.FALSE); }
    "vazio"                  { return symbol(sym.VOID); }
    "funcao"              { return symbol(sym.FUNCTION); }
    "parar"                 { return symbol(sym.BREAK); }
    "continuar"              { return symbol(sym.CONTINUE); }

    // Operadores aritméticos
    "+"                     { return symbol(sym.PLUS); }
    "-"                     { return symbol(sym.MINUS); }
    "*"                     { return symbol(sym.TIMES); }
    "/"                     { return symbol(sym.DIVIDE); }
    "%"                     { return symbol(sym.MOD); }

    // Operadores relacionais
    "=="                    { return symbol(sym.EQ); }
    "!="                    { return symbol(sym.NE); }
    "<"                     { return symbol(sym.LT); }
    "<="                    { return symbol(sym.LE); }
    ">"                     { return symbol(sym.GT); }
    ">="                    { return symbol(sym.GE); }

    // Operadores lógicos
    "&&"                    { return symbol(sym.AND); }
    "||"                    { return symbol(sym.OR); }
    "!"                     { return symbol(sym.NOT); }

    // Operadores de atribuição
    "="                     { return symbol(sym.ASSIGN); }
    "+="                    { return symbol(sym.PLUS_ASSIGN); }
    "-="                    { return symbol(sym.MINUS_ASSIGN); }
    "*="                    { return symbol(sym.TIMES_ASSIGN); }
    "/="                    { return symbol(sym.DIVIDE_ASSIGN); }

    // Delimitadores
    ";"                     { return symbol(sym.SEMICOLON); }
    ","                     { return symbol(sym.COMMA); }
    "("                     { return symbol(sym.LPAREN); }
    ")"                     { return symbol(sym.RPAREN); }
    "{"                     { return symbol(sym.LBRACE); }
    "}"                     { return symbol(sym.RBRACE); }
    "["                     { return symbol(sym.LBRACKET); }
    "]"                     { return symbol(sym.RBRACKET); }

    // Tipos
    {FLOAT}                 { return symbol(sym.FLOAT_LITERAL, Double.parseDouble(yytext())); }
    {INTEGER}               { return symbol(sym.INT_LITERAL, Integer.parseInt(yytext())); }
    {STRING_LITERAL} { return symbol(sym.STRING_LITERAL, yytext().substring(1, yytext().length() - 1)); }

    // Identificadores
    {IDENTIFIER}            { return symbol(sym.IDENTIFIER, yytext()); }

    // Caracteres ilegais
    .                       {
        System.err.println("Caractere ilegal na linha " + (yyline+1) +
                          ", coluna " + (yycolumn+1) + ": '" + yytext() + "'");
        System.exit(1);
    }
}
