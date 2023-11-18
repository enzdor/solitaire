# Solitaire clone

TODO:
- add possibility to move group of cards
- add rules for moving cards?

MAYBE:
- make the are over a card be the whole card over the under card, not just the cursor (complications when card is over two cards, would have to check if cursor is over one or the other card, if it isn't over any go back to orig pos)

Plan:
- Entities
    - Board
    - Card
    - Stock: will contain all of the cards not on the board
    - Waste: cards drawn from the stock, face up and not used
    - Pile: there are seven of them with one face up card at the bottom
    - Foundations: four of them, one for each suit

Card:
- Suit
- Rank
- face down or face up
If the card is face down, check if it can be flipped.
If it is facedown, it cannot be moved.

Game loop
1. deal cards
2. move cards
3. turn card to waste from stock
4. go back to step 2
5. no more cards in stock, move waste to stock
6. go back to step 2
7. if no longer able to make meaningful moves, the player has lost

Mechanics
- Move card from stock to waste [done]
- Move card from waste to pile
- Move card from pile to pile
- Move card from pile to foundation
- Move card from foundation to pile
- Move card from waste to foundation
- Move parts of piles to other piles
- Flip face down cards in piles to face up

To move one card from place to place, check if mouse is over section where card can be dropped.
The main function controlling the mechanics will called something like move() if move is true,
the card will be moved along with the cursor as long as the left click is held down.

- Cards by Byron Knoll https://code.google.com/archive/p/vector-playing-cards/ 
