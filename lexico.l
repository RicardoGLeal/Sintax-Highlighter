%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <fstream>
    #include <iostream>
    
    using namespace std;
    void saveToken(string text_data, string token_type, string);
    void saveToken(string text_data, string);
    void addNewLine(string);
    void createSetup(string);

    ofstream file;
%}

%option c++
%option outfile="Scanner.cpp"
%option case-insensitive
%option noyywrap


DIGITO [0-9]
LETRA [a-zA-ZñÑ]
RESERVADA ("for"|"if"|"else"|"while"|"||"|"!"|"&&"|"return"|"continue"|"break"|"class"|"or"|"not"|"and")
VARIABLE ("bool"|"float"|"int"|"char"|"string")
BOOLEANOS ("false"|"true")

OPERADOR ("!"|"%"|"^"|"&"|"-"|"+"|"=")

ENTERO {DIGITO}+|"-"{DIGITO}+
REAL {DIGITO}+"."{DIGITO}+|"-"{DIGITO}+"."{DIGITO}+|"-"{DIGITO}+"."

IDENTIFICADOR {LETRA}({LETRA}|{DIGITO}|"_")*
SIMBOLO_ESPECIAL ("("|")"|"{"|"}"|"["|"]")
OPERADORES_LOGICOS ("<"|">"|">="|"<="|"=="|"!=")

CARACTER "'"{LETRA}"'"
STRING "\""{LETRA}+"\""
COMENTARIOS "//".+|"#".+

FUNCION {IDENTIFICADOR}"()"

DELIMITADOR [\n]

%%

{ENTERO}                {saveToken(yytext, "\"Numero_Entero\"");}
{REAL}                  {saveToken(yytext, "\"Numero_Real\"");}
{RESERVADA}             {saveToken(yytext, "\"Reservada\"");}
{VARIABLE}             {saveToken(yytext, "\"Variable\"");}
{BOOLEANOS}             {saveToken(yytext, "\"Booleano\"");}
{IDENTIFICADOR}         {saveToken(yytext, "\"Identificador\"");}
{COMENTARIOS}           {saveToken(yytext, "\"Comentario\"");}
{FUNCION}               {saveToken(yytext, "\"Funcion\"");}
{OPERADOR}              {saveToken(yytext, "\"Operador\"");}
{SIMBOLO_ESPECIAL}      {saveToken(yytext, "\"Simbolo_Especial\"");}
{OPERADORES_LOGICOS}    {saveToken(yytext, "\"Operadores_Logicos\"");}
{CARACTER}              {saveToken(yytext, "\"Caracter\"");}
{STRING}                {saveToken(yytext, "\"String\"");}
{DELIMITADOR}           {addNewLine();}
.                       {saveToken(yytext);}
%%

bool setup = false;
void createSetup(string filePath){
    ofstream file_out;
    file_out.open(filePath, std::ios_base::app);
    file_out<<"<head>";
    file_out<<"<link rel=\"stylesheet\" href=\"output_file.css\">";
    file_out<<"</head>";
    file_out<<"<body style=\"background-color: #1e1e1e\">";
}

void saveToken(string text_data, string token_type, string filePath){
	ofstream file_out;
    if(!setup) createSetup(filePath);

    file_out.open(filePath, std::ios_base::app);
    file_out <<"<div class="<< token_type <<" data-hover="<<token_type<<">"<<text_data<<"</div>";
    file_out.close();
}

void saveToken(string text_data, string filePath){
	ofstream file_out;
    if(!setup) createSetup(filePath);

    file_out.open(filePath, std::ios_base::app);
    file_out<<text_data;
    file_out.close();
}

void addNewLine(string filePath){
	ofstream file_out;
    if(!setup) createSetup(filePath);

    file_out.open(filePath, std::ios_base::app);
    file_out<<"<br/>";
    file_out.close();
}


