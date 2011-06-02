
## 1.0.4 [02 June 2011]
* Archive listing should be reversed


## 1.0 [13 March 2011]

* Venue Details
* Ticket Pricing & Link
* Feature-ability
* Image attachment
* Ticket price requires a number
* Datetime select defaults noon to 1pm
* Scopes: featured, not_featured, upcoming & current
* Friendly ID based on titles
* Archiving
* Admin screen separates events by their status (TODO: pagination somehow)
* Reasonable validations
* Practical instance methods to check against scopes
* Next & previous navigation on individual event pages.
* has_many :categories, :through => :categorizations, :source => :event_category
* RSS feed of current, upcoming & featured events
* RSS in sidebar && autodiscovery
* Basic layout and styling to get started immediately [blake0102](http://github.com/blake0102)
* Easily hook onto a few semantic CSS classes built into the markup [blake0102](http://github.com/blake0102)
* Basic Facebook & Twitter sharing interface