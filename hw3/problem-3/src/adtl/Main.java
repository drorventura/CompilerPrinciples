package adtl;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

import adtl.ast.ASTToString;
import adtl.ast.Node;


/**
 * Entry point for the front-end.
 * 
 * @author romanm
 */
public class Main {
	public static boolean rawQuotes = true;

	public static void main(String[] args) {
		if (args.length == 1 && args[0].equals("-help")) {
			printHelp();
		} else if (args.length == 2 && args[0].equals("-tokens")) {
			printTokens(args[1]);
		} else if (args.length == 2 && args[0].equals("-parse")) {
			parse(args[1], false);
		} else if (args.length == 2 && args[0].equals("-debug_parse")) {
			parse(args[1], true);
		} else if (args.length >= 2 && args[0].equals("-format")) {
			rawQuotes = true;
			String outputFileName = null;
			if (args.length == 3)
				outputFileName = args[2];
			format(args[1], outputFileName);
		} else {
			System.out.println("Illegal input!");
			printHelp();
		}
	}

	private static void printHelp() {
		System.out.println("Usage:");
		System.out
				.println("-tokens <file>                 	    Lists the sequence of tokens in the file");
		System.out
				.println("-parse <file>                       Checks whether the file is syntactically correct");
		System.out
				.println("-debug_parse <file>                 Runs the parser with extra debugging output");
		System.out
				.println("-format <input-file>                Outputs a pretty-printed version of input-file to the console");
		System.out
				.println("-format <input-file> <output-file>  Outputs a pretty-printed version of input-file into output-file");
	}

	/**
	 * Prints the elements of tokens, one token per line.
	 * 
	 * @param filename
	 *            The name of the input file.
	 */
	public static void printTokens(String filename) {
		FileReader txtFile;
		try {
			txtFile = new FileReader(filename);
			Lexer scanner = new Lexer(txtFile);
			Token token = null;
			do {
				token = scanner.next_token();
				if (token != null) {
					System.out.println(token.toString());
				}
			} while (token != null && token.sym != sym.EOF);
		} catch (FileNotFoundException e) {
			System.out.print("File not found: " + filename);
		} catch (IOException e) {
			System.out.print("Error reading file: " + filename);
		} catch (LexicalError e) {
			System.out.print(e.formatErrorMessage());
		}
	}

	/**
	 * Attempt to parse a given file.
	 * 
	 * @param inputFileName
	 *            The name of the file.
	 * @param debug
	 *            Indicates whether extra debugging information should be
	 *            emitted by the internal CUP parser.
	 */
	public static void parse(String inputFileName, boolean debug) {
		FileReader txtFile;
		try {
			txtFile = new FileReader(inputFileName);
			Lexer scanner = new Lexer(txtFile);
			Parser parser = new Parser(scanner);
			if (debug)
				parser.debug_parse();
			else
				parser.parse();
			System.out.println("Program " + inputFileName
					+ " parsed successfully!");
		} catch (FileNotFoundException e) {
			System.out.print("File not found: " + inputFileName);
		} catch (IOException e) {
			System.out.print("Error reading file: " + inputFileName);
		} catch (SyntaxError e) {
			System.out.print(e.getMessage());
		} catch (LexicalError e) {
			System.out.print(e.formatErrorMessage());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void format(String inputFilename, String outputFileName) {
		FileReader txtFile;
		try {
			txtFile = new FileReader(inputFilename);
			Lexer scanner = new Lexer(txtFile);
			Parser parser = new Parser(scanner);
			Node ast = (Node) parser.parse().value;
			ASTToString stringer = new ASTToString();
			String output = stringer.toString(ast);

			if (outputFileName == null) {
				System.out.println(output);
			} else {
				File file = new File(outputFileName);
				file.createNewFile();
				FileWriter writer = new FileWriter(outputFileName);
				writer.write(output);
				writer.close();
			}
		} catch (FileNotFoundException e) {
			System.out.print("File not found: " + inputFilename);
		} catch (IOException e) {
			System.out.print("Error reading file: " + inputFilename);
		} catch (SyntaxError e) {
			System.out.print(e.getMessage());
		} catch (LexicalError e) {
			System.out.print(e.formatErrorMessage());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}