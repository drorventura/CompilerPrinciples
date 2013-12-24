package ADTL;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

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
	 * Prints the list of tokens, one token per line.
	 * 
	 * @param filename
	 *            The name of the input file.
	 */
	public static void printTokens(String filename) {
		FileReader txtFile;
		try {
			txtFile = new FileReader(filename);
			// Roman: the compilation error below will go away once you use JFlex to generate the Lexer class.
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
		// The code here will be supplied with the next assignment.
	}

	public static void format(String inputFilename, String outputFileName) {
		// The code here will be supplied with the next assignment.
	}
}