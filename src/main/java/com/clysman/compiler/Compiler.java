package com.clysman.compiler;

import java.io.*;

public class Compiler {
    public static void main(String[] args) {
        try {
            InputStream inputStream = Compiler.class.getClassLoader().getResourceAsStream("input.txt");

            if (inputStream == null) {
                System.err.println("Arquivo input.txt não encontrado em src/main/resources.");
                return;
            }

            BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
            scanner scanner = new scanner(reader);
            parser parser = new parser(scanner);

            parser.parse();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}