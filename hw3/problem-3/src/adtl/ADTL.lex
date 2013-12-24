package adtl;

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

%eofval{
  return new Token(sym.EOF, getLineNumber());
%eofval}

InputCharacter		= [^\r\n]
LineTerminator		= \r|\n|\r\n
Whitespace          = [ \t\r\n\f]+
EndOfLineComment    = "//" {InputCharacter}* {LineTerminator}

FirstIdentChar		= [_a-zA-Z]
NextIdentChar       = [_0-9a-zA-Z]
Id 					= {FirstIdentChar}{NextIdentChar}*

PosDigit			= [1-9]
Digit				= [0-9]
PosInteger			= {PosDigit} {Digit}*
Integer				= [0] | {PosInteger} | -{PosInteger}

%state STRING
%state MULTILINE_COMMENT

%%

<YYINITIAL> {
  ///////////
  // Keywords
  
  "assert"          { return new Token(yytext(), sym.ASSERT, getLineNumber()); }
  "set"           	{ return new Token(yytext(), sym.SET, getLineNumber()); }
  "else"            { return new Token(yytext(), sym.ELSE, getLineNumber()); }
  "lock"           	{ return new Token(yytext(), sym.LOCK, getLineNumber()); }
  "if"              { return new Token(yytext(), sym.IF, getLineNumber()); }
  "new"				{ return new Token(yytext(), sym.NEW, getLineNumber()); }
  "in"             	{ return new Token(yytext(), sym.IN, getLineNumber()); }
  "rev"            	{ return new Token(yytext(), sym.REV, getLineNumber()); }
  "return"          { return new Token(yytext(), sym.RETURN, getLineNumber()); }
  "choose"          { return new Token(yytext(), sym.CHOOSE, getLineNumber()); }
  
  ////////////
  // Operators

  "|"                { return new Token(yytext(), sym.BAR, getLineNumber()); }
  "("                { return new Token(yytext(), sym.LP, getLineNumber()); }
  ")"                { return new Token(yytext(), sym.RP, getLineNumber()); }
  "{"                { return new Token(yytext(), sym.LCBR, getLineNumber()); }
  "}"                { return new Token(yytext(), sym.RCBR, getLineNumber()); }
  ","                { return new Token(yytext(), sym.COMMA, getLineNumber()); }
  ";"                { return new Token(yytext(), sym.SEMI, getLineNumber()); }
  "."                { return new Token(yytext(), sym.DOT, getLineNumber()); }
  ":"                { return new Token(yytext(), sym.COLON, getLineNumber()); }
  "@"               { return new Token(yytext(), sym.AT, getLineNumber()); }
  "&&"               { return new Token(yytext(), sym.LAND, getLineNumber()); }
  "||"               { return new Token(yytext(), sym.LOR, getLineNumber()); }
  "!"                { return new Token(yytext(), sym.NOT, getLineNumber()); }
  "=="               { return new Token(yytext(), sym.EQ, getLineNumber()); }
  "!="               { return new Token(yytext(), sym.NEQ, getLineNumber()); }
  "<"                { return new Token(yytext(), sym.LT, getLineNumber()); }
  ">"                { return new Token(yytext(), sym.GT, getLineNumber()); }
  "<="               { return new Token(yytext(), sym.LTE, getLineNumber()); }
  ">="               { return new Token(yytext(), sym.GTE, getLineNumber()); }
  "="                { return new Token(yytext(), sym.ASSIGN, getLineNumber()); }
  "+"                { return new Token(yytext(), sym.PLUS, getLineNumber()); }
  "-"                { return new Token(yytext(), sym.MINUS, getLineNumber()); }
  "*"                { return new Token(yytext(), sym.TIMES, getLineNumber()); }
  "/"                { return new Token(yytext(), sym.DIVIDE, getLineNumber()); }
  "+="               { return new Token(yytext(), sym.ASSIGN_PLUS, getLineNumber()); }
  "-="               { return new Token(yytext(), sym.ASSIGN_MINUS, getLineNumber()); }
  
  ////////////////////////
  // Value-carrying tokens
  
  {Id} 				 { return new Token(yytext(), sym.ID, getLineNumber(), yytext()); }
  {Integer}			 	 { return new Token(yytext(), sym.INT, getLineNumber(), new Integer(yytext()).intValue()); }
  \"                 { string = new StringBuffer(); yybegin(STRING); }

  //////////////////////////  
  // Comments and whitespace
  
  "/*"       		 { yybegin(MULTILINE_COMMENT); }
  {EndOfLineComment} { }
  {Whitespace}       { }
  
  // Error cases
  {Integer}0			 { throw new LexicalError(yytext() + " trailing 0's", getLineNumber()); }
  {Integer}.0			 { throw new LexicalError(yytext() + " empty fraction", getLineNumber()); }
  0{Integer}			 { throw new LexicalError(yytext() + " leadin 0's", getLineNumber()); }
  {Integer}{Id}			 { throw new LexicalError("'" + yytext() + "' illegal combination of digits and letters", getLineNumber()); }
  ".."			 	 	{ throw new LexicalError("'" + yytext() + "' too many dots", getLineNumber()); }
  .                  	{ throw new LexicalError(yytext() + " is an illegal token", getLineNumber()); }
}

<STRING> {
  \"                             { yybegin(YYINITIAL); 
                                   return new Token(yytext(), sym.QUOTE, getLineNumber(), string.toString()); }
  [^\n\r\"\\]+                   { string.append( yytext() ); }
  \\t                            { if (Main.rawQuotes) string.append("\\t"); else string.append('\t'); }
  \\n                            { if (Main.rawQuotes) string.append("\\n"); else string.append('\n'); }
  \\r                            { if (Main.rawQuotes) string.append("\\r"); else string.append('\r'); }
  \\\"                           { if (Main.rawQuotes) string.append("\\\""); else string.append('\"'); }
  \\                             { if (Main.rawQuotes) string.append("\\"); else string.append('\\'); }

  // Error case
  \\[^\n\r\t\"\\]                 { throw new LexicalError("\"" + yytext() + "\"" + " is an illegal escape sequence", getLineNumber()); }
}

<MULTILINE_COMMENT> {
  "*/"						{ yybegin(YYINITIAL); }
  .|{LineTerminator}		{}
}