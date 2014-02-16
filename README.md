# Solitaire Cipher

This is a implementation of Bruce Schneier solitaire cipher.

Given the following text "Hello World Earth No.1" the algorthm encrypts and decrypts the text using the following steps:-

1. Strip non a-z charecters from the text such that the result is `<Hello World Earth No>`

2. Uppercase all the charecters `<HELLO WORLD EARTH>`

3. Group the text into groups of 5 charecters `<HELLO WORLD EARTH>` adding X for remaining part of a group which doesn't have any charecters.

4. Convert the text to numbers so  `<HELLO WORLD EARTH>` will turn into `<8 5 12 12 15 23 15 18 12 4 5 18 20 8>`

5. Sets up a deck of cards plus two jokers

6. Moves the first joker by one space.

7. Moves the second joker by two places.

8. Perform a triple cut on the deck of cards `[ 2, 4, 6, "B", 5, 8, 7, 1, "A", 3, 9 ]` becomes `[ 3, 9, "B", 5, 8, 7, 1, "A", 2, 4, 6 ]`.

9. Perform a count cut resulting in the following result `[1, "A", 2, 4, 3, 9, "B", 5, 8, 7, 6  ]`

10. Produce output letters based on the last item of the deck of cards so `6` becomes "E" and repeat this for every character of the text.

11. Add the keystream produced from the step above to the numbers produced from the text. 