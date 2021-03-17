# Multi Container App

> **This is an over the top, way more complicated application that it should be, but it's helpful to learn how to use more than one container in the same application.**

It calculates the Fibonacci number of a particular index of the sequence.

## How does it work

When the user boots up their browser and tries to visit our application they-re going to first visit an Nginx web server. 

This server is going to decide whether that browser is trying to access a React App to get some frontend assets (like HTML files or some JS files) or whether that browser is trying to access some backend API that are used to submit and read numbers, among other things.

So, the first route will be to a React App and the second to an Express Server.

### Going deeper

The application frontend has two sections:
- "Values I have seen": Which shows the indices I've entered. This data is saved to a Postgres database.
- "Calculated values": Which shows the number calculated for a specific index. It's saved to a Redis database.

### Flow

1. The user submits a Fibonacci index to the React App. Enters a Fibonacci index in the input textbox and press submit.
2. The React App makes a request to the Express Server.
3. The Express Server will receive thas index needed to calculate a Fibonacci number.
    1. First it takes that index and store it inside the Postgre database.
    2. At the same time it will take the index again and put it into the Redis database.
4. When a new number shows up inside of the Redis database, it's going to take up a separate backend NodeJS process, that it's called Worker.
5. The only job of this Worker is to watch for new indices that show up in Redis.
    1. Each time it happens, the Worker will pull the value out.
    2. Then it will calculate the Fibonacci number for that index.
    3. Finally it will put that calculated number back into Redis, so that it can then be requested by the React App and eventually show up on the screen.


> **Again, this is an way more complicated application that it should be, but it's helpful to learn how to use more than one container in the same application.**
