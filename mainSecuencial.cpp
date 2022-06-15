#include <iostream>
#include <fstream>
#include <stdio.h>  
#include <chrono>
#include <vector>
#include "FlexLexer.h"
#include <experimental/filesystem>
namespace fs = std::experimental::filesystem;
using namespace std::chrono;
using namespace std;

string getFilenameFromPath(string path);

void createHTMLFile(vector<string> files){
    ofstream file_out;
    file_out.open("output_file.html", std::ios_base::app);
    file_out<<"<head>";
    file_out<<"<link rel=\"stylesheet\" href=\"output_file.css\">";
    file_out<<"</head>";
    file_out<<"<body style=\"background-color: #1e1e1e\">";

    for (string file : files)
    {
        file_out << "<div class=\"card\">" << endl;
        file_out << "<a href=" << file << ">" << file << "</a>" << endl;
        file_out << "</div>" << endl;    }
}

string getFilenameFromPath(string path)
{
    stringstream path_(path);
    string segment;
    vector<string> seglist;

    while (getline(path_, segment, '/'))
    {
        seglist.push_back(segment);
    }
    return seglist.back() + ".html";
}

void runFile(string path) {
    string file = getFilenameFromPath(path);
    cout<<path<<endl;
    ifstream in(path);
    yyFlexLexer* lexer = new yyFlexLexer(&in);
    lexer->setFileName(file);
    while(lexer->yylex() != 0);
    // return;
}

int main()
{
    auto start = high_resolution_clock::now();
    string path = "/mnt/c/Users/ricar/Documents/Resaltador de sintaxis/entradas";
    vector<string> files;
    int filesCount = 0;
    int aux = 0;

    for (const auto &entry : fs::directory_iterator(path)){
        cout << entry.path() << endl;
        string file = getFilenameFromPath(entry.path());
        files.push_back(file);
        runFile(entry.path());
        aux++;
    }

    createHTMLFile(files);
    
    auto stop = high_resolution_clock::now();
    auto duration = duration_cast<microseconds>(stop - start);
    cout << "Tiempo Total (secuencial) : " << duration.count() << endl;
    return 0;
}