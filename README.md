# vending-machine
A ruby program that mimics the functionality of a vending machine

### Brief

Design a vending machine that behaves as follows:

- Once an item is selected and the appropriate amount of money is inserted, the vending machine should
  return the correct product.
- It should also return change if too much money is provided, or ask for more money if insufficient
  funds have been inserted.
- The machine should take an initial load of products and change. The change will be of denominations
  1p, 2p, 5p, 10p, 20p, 50p, £1, £2.
- There should be a way of reloading either products or change at a later point.
- The machine should keep track of the products and change that it contains.

### Approach

I began by splitting the responsibilities out initially into 4 classes on paper: VendingMachine,
ProductHandler, ChangeHandler, and ChangeCalculator. The handler classes are responsible for holding
and changing their own internal states. The calculator was responsible for doing the hard leg work when
it came to calculating change in coins, which I deemed to be the trickiest part of the challenge. The
vending machine was responbile for bringing everything together into one interface. I later added a
ValueCalculator to handle calculating the total integer value of a collection of coins.

In the code, I decided to set up some initial feature specs that encompassed the core functionality that
the program needed to have. I let these tests drive the code, which led to a process in which classes and
their methods were added when needed rather than being created in an attempt to preempt code needs.

I decided to make the lookup table accessable to all files for ease, and similarly decided to make
the ChangeCalculator and ValueCalculator service objects rather than have classes instantiate with them
passed in. I like this decision, as it shows a separation between objects that are integral to the make up
of the vending machine, and objects that are simply used as mathematical tools.

In total I spent about 6 - 6.5 hours on this project over the span of a few days, with some of that time
dedicated to changes such as refactoring, name changes, and edge case testing after I was satisfied that
I had got the core requirements locked down. Realistically I could have stopped sooner, and I could have
also coded for longer; but this felt like the right amount of time to create a program that I'm happy
enough to call finished.

### What would I like to change / add if I had more time?

- Error handling rather than simply returning strings.
- A class devoted to the custom messages.
- Test cases for things like trying to load or pay with invalid coins.
- Clean up of the ChangeCalculator #call method so that it's more human readable and not so long.
- The handler classes are similar in some ways and could potentially inherit some functionality from
  a parent class.
- Make the program runnable in the sense that it asks questions and requires user input (giving it a UI)

### Running tests and linter

To run the tests and linter:
```
$ bundle exec rspec
$ bundle exec rubocop
```

### Usage

First we can set up an irb, requiring the necessary file:
```
$ irb -r './lib/vending_machine'
```

To set up our vending machine, we should first create a product handler and a change handler:
```
product_handler = ProductHandler.new({'sprite': {'price': 90, 'quantity': 1}})
change_handler = ChangeHandler.new({'1p': 10, '50p': 1})
```

We can now create our vending machine with it's initial supplies:
```
vending_machine = VendingMachine.new(product_handler, change_handler)
```

What happens if we try to purchase a product that does not exist or has a quantity of 0?:
```
vending_machine.purchase_product('oreos', {'50p': 1})
=> "Product out of stock, please choose a different product."
```

What happens if we try to purchase a product with insufficient payment?:
```
vending_machine.purchase_product('sprite', {'50p': 1})
=> "Insufficient payment provided."
```

What happens if the machine does not have the right coins to give us change?:
```
vending_machine.purchase_product('sprite', {'£2': 1})
=> "Machine has insufficient change, please provide exact payment."
```

When we successfully purchase a product, it is returned to us with the correct change:
```
vending_machine.purchase_product('sprite', {'£1': 1})
=> {:product=>"sprite", :change=>{:"1p"=>10}}
```

note: The change calculator attempts to return the greatest amount of the highest value coin that
it can, without exceeding the amount that it owes.

We can load the vending machine with product and change like so:
```
vending_machine.load_product({'oreos': {'price': 50, 'quantity': 2}})
vending_machine.load_change({'20p': 5, '£1': 5})
```
