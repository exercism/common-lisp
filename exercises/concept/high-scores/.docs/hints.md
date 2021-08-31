# Hints

# 1. Creating the high score table

- The high score table needs to be a hash table.
- You can create a hash table with `make-hash-table`.

# 2. Adding a player to the table

- Since the player score is not being set here, the value for the key doesn't matter.
- To add a key/value pair to a hash table use `(setf (gethash key table) value)`

# 3. Setting a player's score

- Setting a player's score is almost identical to adding the player to the table.
- To add a key/value pair to a hash table use `(setf (gethash key table) value)`

# 4. Getting a score from the table

- Use `gethash` to get a value for a key from the hash table.
- `gethash` has an optional third argument which is the value to use if the key is not found.

# 5. Removing a player from the table

- Use `remhash` to remove a key from the table.

