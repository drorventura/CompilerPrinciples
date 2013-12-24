package ADTL;

%%

%class Lexer
%cup
%public
%type Token
%line
%scanerror LexicalError

%{
StringBuffer string = new StringBuffer();

public int getLineNumber() { return yyline + 1; }
%}

DecIntegerLiteral = 0 | [1-9][0-9]*

LetterLiteral = [a-z] | [A-Z]
Identifier = ("_" | {LetterLiteral} ) ("_" | {LetterLiteral} | {DecIntegerLiteral} )*

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace = {LineTerminator} | [ \t\f]

Comment = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment}
TraditionalComment = "/*" [^*] ~"*/" | "/*" "*"+ "/"
EndOfLineComment = "//" {InputCharacter}* {LineTerminator}
DocumentationComment = "/**" {CommentContent} "*"+ "/"
CommentContent = ( [^*] | \*+ [^/*] )*

BadString = '|"'" [^'] ~"'"

%eofval{
  return new Token(sym.EOF, getLineNumber());
%eofval}

%state STRING

%%


<YYINITIAL>{
    /* reserved words */
    "rev"                   { return new Token(yytext(), sym.REV, getLineNumber()); }
    "assert"                { return new Token(yytext(), sym.ASSERT, getLineNumber()); }
    "if"                    { return new Token(yytext(), sym.IF, getLineNumber()); }
    "else"                  { return new Token(yytext(), sym.ELSE, getLineNumber()); }
    "return"                { return new Token(yytext(), sym.RETURN, getLineNumber()); }
    "new"                   { return new Token(yytext(), sym.NEW, getLineNumber()); }
    "set"                   { return new Token(yytext(), sym.SET, getLineNumber()); }
    "choose"                { return new Token(yytext(), sym.CHOOSE, getLineNumber()); }
    "in"                    { return new Token(yytext(), sym.IN, getLineNumber()); }
    "lock"                  { return new Token(yytext(), sym.LOCK, getLineNumber()); }

    /* literals */
    {DecIntegerLiteral}     { return new Token(yytext(), sym.INT, getLineNumber(), Integer.parseInt(yytext())); }
    {Identifier}            { return new Token(yytext(), sym.ID, getLineNumber(), yytext()); }

    /* operators */
    "|"                     { return new Token(yytext(), sym.BAR, getLineNumber()); }
    "||"                    { return new Token(yytext(), sym.LOR, getLineNumber()); }
    "&&"                    { return new Token(yytext(), sym.LAND, getLineNumber()); }
    "/"                     { return new Token(yytext(), sym.DIVIDE, getLineNumber()); }
    "*"                     { return new Token(yytext(), sym.TIMES, getLineNumber()); }
    "-"                     { return new Token(yytext(), sym.MINUS, getLineNumber()); }
    "+"                     { return new Token(yytext(), sym.PLUS, getLineNumber()); }
    "+="                    { return new Token(yytext(), sym.ASSIGN_PLUS, getLineNumber()); }
    "-="                    { return new Token(yytext(), sym.ASSIGN_MINUS, getLineNumber()); }
    "!"                     { return new Token(yytext(), sym.NOT, getLineNumber()); }
    "="                     { return new Token(yytext(), sym.ASSIGN, getLineNumber()); }
    "=="                    { return new Token(yytext(), sym.EQ, getLineNumber()); }
    "!="                    { return new Token(yytext(), sym.NEQ, getLineNumber()); }
    "<"                     { return new Token(yytext(), sym.LT, getLineNumber()); }
    ">"                     { return new Token(yytext(), sym.GT, getLineNumber()); }
    "<="                    { return new Token(yytext(), sym.LTE, getLineNumber()); }
    ">="                    { return new Token(yytext(), sym.GTE, getLineNumber()); }

    /* punctuation */
    "{"                     { return new Token(yytext(), sym.LCBR, getLineNumber()); }
    "}"                     { return new Token(yytext(), sym.RCBR, getLineNumber()); }
    ";"                     { return new Token(yytext(), sym.SEMI, getLineNumber()); }
    ":"                     { return new Token(yytext(), sym.COLON, getLineNumber()); }
    "("                     { return new Token(yytext(), sym.LP, getLineNumber()); }
    ")"                     { return new Token(yytext(), sym.RP, getLineNumber()); }
    ","                     { return new Token(yytext(), sym.COMMA, getLineNumber()); }
    "."                     { return new Token(yytext(), sym.DOT, getLineNumber()); }
    "@"                     { return new Token(yytext(), sym.AT, getLineNumber()); }
    \"                      { string.setLength(0); yybegin(STRING); }

    "$"                     { throw new LexicalError("Invalid Syntax $", getLineNumber()); }
    "~"                     { throw new LexicalError("Invalid Syntax ~", getLineNumber()); }
    "^"                     { throw new LexicalError("Invalid Syntax ^", getLineNumber()); }
    {WhiteSpace}            { /* take no action */ }
    {Comment}               { /* take no action */ }
    {BadString}             { throw new LexicalError("Invalid Stntax of String: " + yytext(), getLineNumber()); }
    {LineTerminator}        { throw new LexicalError("Invalid sequence \n\r\t\\ not in a string", getLineNumber()); }

}

<STRING>{
    \"                      { yybegin(YYINITIAL);
                              return new Token(string.toString(),
                                               sym.QUOTE,
                                               getLineNumber(),
                                               string.toString()); }
    [^\n\t\r\"\\]+          { string.append( yytext() ); }
    \\t                     { string.append("\\t"); }
    \\n                     { string.append("\\n"); }
    \\r                     { string.append("\\r"); }
    \\\"                    { string.append("\\\""); }
    \\\\                    { string.append("\\\\"); }

    \\a                     { throw new LexicalError("\\a - Invalid Escape Sequence", getLineNumber()); }
    \\s                     { throw new LexicalError("\\s - Invalid Escape Sequence", getLineNumber()); }
    \\m                     { throw new LexicalError("\\m - Invalid Escape Sequence", getLineNumber()); }
    \\                      { throw new LexicalError("\\ - Invalid Escape Sequence", getLineNumber()); }

}
