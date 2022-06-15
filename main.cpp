// Resaltador de sintaxis.cpp : Este archivo contiene la función "main". La ejecución del programa comienza y termina ahí.

#include "FlexLexer.h"
#include <stdio.h>
#include <iostream>
#include <fstream>
#include <string>
using namespace std;

int main()
{
    int option;
    cout << "Introduce una opcion \n1: Secuencial \n2: Paralelo" << endl;
    // cin >> option;
    option = 1;
    switch (option)
    {
    case 1:
        cout<<"Secuencial:"<<endl;
        system("g++ -o a.out mainSecuencial.cpp Scanner.cpp -lstdc++fs");
        system("./a.out");
        return 0;
        break;
    case 2:
        cout<<"Paralelo:"<<endl;
        system("g++ -pthread -o a.out mainParalelo.cpp Scanner.cpp -lstdc++fs");
        system("./a.out");
        return 0;
        break;
    default:
        break;
    }
    return 0;
}