# Promise.lua
A JavaScript-style Promise library for Lua

See https://ezhik.jp/promise.lua for more information and a playground.

# The API
I tried to cover most of the API I saw on [MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise):
* Constructor
	* **`Promise.new(fn)`** – returns a new Promise. `fn` is a function which takes in two parameters, `resolve` and `reject`, both of which are functions that will either resolve or reject the promise with the given value. If the value given to `resolve` is a promise or a table that has a `next` method, it will use the result of that method instead. 
* Instance methods
	* **`:next(onFulfilled, onRejected)`** – registers callbacks to run when the promise is settled (either fulfilled or rejected). This is called `next` instead of `then` as `then` is a reserved keyword in Lua.
	* **`:catch(onRejected)`** – registers a callback to run when the promise is rejected.
	* **`:finally(onFinally)`** – registers a callback that will run when the promise is settled. This promise will settle with whatever the original promise's state is.
* Static methods
	* **`Promise.all(promises)`** – takes a list of promises and returns a promise that is fulfilled when all input promises are fulfilled or is rejected when any of the promises are rejected.
	* **`Promise.allSettled(promises)`** – takes a list of promises and returns a promise that is fulfilled when all input promises are settled with a list of tables in the shape of `{ status = "fulfilled", value = <...> }` or `{ status = "rejected", reason = <...> }`.
	* **`Promise.any(promises)`** – takes a list of promises and returns a promise that is fulfilled when any of the input promises are fulfilled or is rejected when all of the input promises are rejected.
	* **`Promise.race(promises)`** – takes a list of promises and returns a promise that is settled with the state of the first promise in the list to settle.
	* **`Promise.reject(reason)`** – returns a promise that's rejected with the given reason.
	* **`Promise.resolve(value)`** – returns a promise that's resolved with the given value.
	* **`Promise.try(fn)`** – takes a callback of any kind and wraps its result in a promise.
	* **`Promise.withResolvers()`** – returns a promise, its `resolve` function, and its `reject` function.
I also added a few extra helpers for my own sake:
* Async-await
	* **`Promise.async(fn)`** – returns a function that returns a promise that will be resolved or rejected based on the result of executing `fn` in a coroutine.
	* **`:await()`** – if executed from a coroutine, will yield until the promise is settled and return the resolved value or `error` with the rejection reason.
* Various
	* **`:ok()`** – converts rejections of the promise into `nil`, think Rust's [Result.ok()](https://doc.rust-lang.org/std/result/enum.Result.html#method.ok).
	* **`:print()`** – prints the settled result of the promise without modifying it.

I've kept this async runtime-agnostic. You can override the **`Promise.schedule(fn)`** function with your own implementation that will schedule functions for later asynchronous execution. An example implementation for Hammerspoon is provided in the repository.
