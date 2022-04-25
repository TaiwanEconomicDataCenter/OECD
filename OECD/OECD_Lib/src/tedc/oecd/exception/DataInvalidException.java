package tedc.oecd.exception;

public class DataInvalidException extends RuntimeException {

	public DataInvalidException() {
		super();
	}

	public DataInvalidException(String message, Throwable cause) {
		super(message, cause);
	}

	public DataInvalidException(String message) {
		super(message);
	}

}
