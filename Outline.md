# Gameplay
* "Branch Hopping" game
* Player starts on the ground, and can jump to one of two tree branches (or other platforms of some sort) above them.
* To select a branch to jump to, the player types the word displayed above the branch.
* Making errors causes the branch the player is on to deteriorate and eventually break.
  * The ground cannot deteriorate or break.
* Different types of branches require the player to make decisions, ensuring they pay attention to the screen:
  * Normal: Player can remain in place forever
  * Unstable: Player character will fall after a timeout
  * Missing: Player character will fall immediately
* The game ends once the player falls, and their score is displayed.

## Display
* The player can see their character at the bottom of the screen, along with the branch they are currently on (or the ground), and the next two sets of branches above them.
* The player's view scrolls up as they jump to new branches.
* Each branch displays a word above it.

### Character Entry
* A cursor (highlighted background for one character) starts at the first character of the word for the set of branches immediately above the player.
* The cursor changes according to events:
  * Keyboard input matches both branches
    * Branch cursor turns green then moves to the next character for both branches
  * Keyboard input matches one branch
    * Non-matching branch cursor stays grey
    * Matching branch cursor turns green then moves to the next character
  * Keyboard input doesn't match any branches
    * The cursor for both branches turns red and does not advance.
  * Backspace key is received:
    * Cursor turns grey then moves back one character (doesn't move if at start of word)

### UI Elements
* Current height (branches jumped * 1 meter).
* Speed multiplier
* Current score

# Typing
* Displaying two completely different words on the branches makes the game less entertaining. (This can still be configured by the player.)
  * The player's path would be determined by the first character they type, provided they don't make enough mistakes for the branch they are on to break.
* Instead, each branch displays two words that differ by a certain amount of characters at the end (determined by the game's settings).
  * e.g. *mechanics* and *mechanism*
  * This allows the player to change the branch they are targeting quickly, while also punishing them for making mistakes (e.g. a wrong character could send them to an unstable or empty branch).

# Scoring
* The player earns points by jumping to branches, and loses points by making errors.
* A speed multiplier encourages the player to type quickly.
  * It starts at 1x and doubles for each level it increases by, up to a maximum of 8x.
  * i.e. possible values are 1x, 2x, 4x, 8x
  * Increasing the speed multiplier at 8x or decreasing the speed multiplier at 1x has no effect.
* When the player jumps to a new branch...
  * +1 point/character in the word the branch had * speed multiplier
  * **After** awarding points, speed multiplier goes up 1 level
* When the player makes an error...
  * -1 point
  * Speed multiplier drops down 1 level
* Every 2 seconds...
  * Speed multiplier drops down 1 level

# Settings
* Settings are configured from a file.

## Settings
* Dictionary
* Max characters
* Number of errors for branch to break
* Timeout for unstable branches to break
* Difference between branches (in characters)
  * \> 0 and <= max characters
* Error handling:
  1. Require backspace (i.e. to type "rrr", typing "rrf←r" is valid)
  2. Reject invalid characters (i.e. to type "rrr", typing "rrfr" is valid)
  * Both options still count errors against the player's score. (They just affect what the player has to do after making an error.)
* Branch frequency (% chance):
  1. Normal (0-1)
  2. Unstable (0-1)
  3. Missing (0-0.5)
  * All frequencies must add up to 1.

# Potential Features
* Increase unstable & missing branch frequency as height increases.
* High score chart with player name entry (saved to a file).