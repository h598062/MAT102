public class CaesarCipher {
	public static String encrypt(String plaintext, int shift) {
		StringBuilder encryptedText = new StringBuilder();

		for (char c : plaintext.toCharArray()) {
			if (Character.isLetter(c)) {
				char base          = Character.isLowerCase(c) ? 'a' : 'A';
				char encryptedChar = (char) (((c - base + shift) % 26) + base);
				encryptedText.append(encryptedChar);
			} else {
				encryptedText.append(c);
			}
		}

		return encryptedText.toString();
	}

	public static String decrypt(String ciphertext, int shift) {
		return encrypt(ciphertext, 26 - shift); // Decrypting is just shifting in reverse
	}

	public static void main(String[] args) {
		for (int i = 0; i < 26; i++) {
			System.out.println("Shift: " + i + " " + decrypt("tmdde", i) + " mb: " + decrypt("Macbeth", i));
		}
	}
}
