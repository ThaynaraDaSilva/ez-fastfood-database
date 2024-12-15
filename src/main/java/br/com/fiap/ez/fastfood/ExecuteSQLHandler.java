package br.com.fiap.ez.fastfood;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.Scanner;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;

public class ExecuteSQLHandler implements RequestHandler<Object, String>{
	
	 private final String DB_HOST = System.getenv("DB_HOST");
	    private final String DB_PORT = System.getenv("DB_PORT");
	    private final String DB_NAME = System.getenv("DB_NAME");
	    private final String DB_USER = System.getenv("DB_USER");
	    private final String DB_PASSWORD = System.getenv("DB_PASSWORD");
	    private final String SQL_FILE_PATH = "/resources/database.sql";
	   

	    @Override
	    public String handleRequest(Object input, Context context) {
	        context.getLogger().log("################# Conectando ao banco de dados. #################");

	        String jdbcUrl = String.format("jdbc:postgresql://%s:%s/%s", DB_HOST, DB_PORT, DB_NAME);

	        try (Connection connection = DriverManager.getConnection(jdbcUrl, DB_USER, DB_PASSWORD)) {
	            context.getLogger().log("################# Conexão com o banco de dados estabelecida. #################");
	            
	            InputStream sqlFileStream = getClass().getResourceAsStream(SQL_FILE_PATH);
	            if (sqlFileStream == null) {
	                throw new RuntimeException("################# Arquivo SQL não encontrado em : " + SQL_FILE_PATH + " #################");
	            }

	            // Ler os comandos SQL do arquivo
	            String sqlCommands = new Scanner(sqlFileStream, "UTF-8").useDelimiter("\\A").next();
	            context.getLogger().log(" ################# Comandos SQL carregados:\n  #################" + sqlCommands);

	            // Executar os comandos SQL
	            try (Statement statement = connection.createStatement()) {
	                statement.execute(sqlCommands);
	                context.getLogger().log(" ################# Comandos SQL executados com sucesso.  #################");
	            }

	            return " ################# Execução SQL concluída com sucesso! #################";
	        } catch (Exception e) {
	            context.getLogger().log(" ################# Erro ao executar os comandos SQL: " + e.getMessage()+  " #################");
	            throw new RuntimeException(e);
	        }
	    }

}
