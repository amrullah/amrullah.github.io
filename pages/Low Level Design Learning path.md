filters:: {"templates" false}
type:: [[Internet Resource]] 
alias:: 
link:: https://eminent-croissant-92f.notion.site/LLD-1e85855731e0806ea906f6ddf9616af3 
tags:: System Design

-
- # LLD 
  
  [https://codewitharyan.com/system-design/low-level-design](https://codewitharyan.com/system-design/low-level-design): really good resource for LLD
  
  🔹 **Must-Know:** **Singleton, Factory, Builder, Strategy, Observer, Adapter, Proxy, Decorator, Composite, Flyweight, Template Method, Command, Chain of Responsibility.**
  
  🔹 **Nice-to-Know (But Rarely Asked):** Memento, State, Visitor, Mediator, Interpreter, Bridge.
- ## **🔥 FAANG-Level Design Patterns Roadmap**
- ### **🔥 1. Core OOP Principles (Before Learning Design Patterns)**
  
  ✅ **SOLID Principles** (Single Responsibility, Open-Closed, Liskov, Interface Segregation, Dependency Injection)
  
  ✅ **DRY (Don’t Repeat Yourself) & KISS (Keep It Simple, Stupid)**
  
  ✅ **Composition over Inheritance**
  
  ✅ **Encapsulation, Polymorphism, Abstraction, and Inheritance**
- #### **Hands-On Practice**
  
  ✔ Refactor a **badly written codebase** to follow **SOLID** principles.
  
  ✔ Implement **Dependency Injection** in Java using **Spring Boot**.
-
- ## **🔥 2. Creational Design Patterns (Object Creation)**
  
  ✅ **Singleton** → **Global shared instance (Thread-Safe Singleton, Enum Singleton, Lazy vs Eager Initialization)**
  
  ✅ **Factory Method** → **Encapsulating Object Creation (Factory Pattern, Abstract Factory)**
  
  ✅ **Builder** → **Step-by-step object construction (Immutable Objects, Fluent Interface)**
  
  ✅ **Prototype** → **Cloning objects instead of creating new instances (Shallow vs Deep Copy)**
- ### **Practice Questions**
  
  1️⃣ **How do you make a Singleton thread-safe?**
  
  2️⃣ **When should you use Factory Pattern vs Builder Pattern?**
  
  3️⃣ **How would you design an object cache using Prototype Pattern?**
- ### **Hands-On Practice**
  
  ✔ Implement **Singleton in a Multithreaded environment (With Double-Checked Locking)**
  
  ✔ Create a **Logger using Factory Pattern**
  
  ✔ Build a **User Profile Generator with Builder Pattern**
-
- ## **🔥 3. Structural Design Patterns (Class & Object Composition)**
  
  ✅ **Adapter** → **Convert one interface to another (Connecting Incompatible Interfaces)**
  
  ✅ **Decorator** → **Dynamically adding behavior to objects (Extending Functionality Without Modifying Original Code)**
  
  ✅ **Proxy** → **Controlling access to objects (Virtual Proxy, Protection Proxy, Logging, Security)**
  
  ✅ **Composite** → **Tree-like structure (Building Hierarchical Object Structures)**
  
  ✅ **Flyweight** → **Optimizing memory usage for repeated objects (String Pool, Caching)**
  
  ✅ **Facade** → **Simplifying complex subsystems (Hiding Implementation Details)**
- ### **Practice Questions**
  
  1️⃣ **What is the difference between Proxy and Adapter?**
  
  2️⃣ **When should you use a Decorator instead of Inheritance?**
  
  3️⃣ **How does Flyweight help reduce memory usage?**
- ### **Hands-On Practice**
  
  ✔ Implement a **Cache System using Flyweight Pattern**
  
  ✔ Use **Decorator Pattern to Add Features to a Coffee Shop Ordering System**
  
  ✔ Implement **Proxy Pattern for Lazy Loading Large Objects**
- ## **🔥 4. Behavioral Design Patterns (Object Communication & Behavior)**
  
  ✅ **Strategy** → **Encapsulating algorithms (Choosing Different Sorting Algorithms at Runtime)**
  
  ✅ **Observer** → **Event-driven programming (Publish-Subscribe Model, UI Event Handling)**
  
  ✅ **Command** → **Encapsulating requests as objects (Undo/Redo, Macro Commands)**
  
  ✅ **Template Method** → **Defining the structure of an algorithm while allowing subclasses to customize behavior**
  
  ✅ **Chain of Responsibility** → **Passing requests along a chain of handlers (Logging, Middleware, Request Processing)**
  
  ✅ **State** → **Managing object state changes dynamically (Finite State Machines, UI Components)**
- ### **Practice Questions**
  
  1️⃣ **How does Strategy Pattern help remove if-else conditions?**
  
  2️⃣ **What is the difference between Observer and Pub-Sub?**
  
  3️⃣ **How would you implement Undo-Redo using the Command Pattern?**
- ### **Hands-On Practice**
  
  ✔ Implement **Strategy Pattern for a Payment Gateway (Credit Card, UPI, PayPal)**
  
  ✔ Design a **Notification System using Observer Pattern**
  
  ✔ Implement **Command Pattern for Undo/Redo in a Text Editor**
- ## **🔥 5. Low-Level Design (LLD) – FAANG System Design Approach**
  
  LLD **focuses on designing real-world applications using OOP, Design Patterns, and Best Practices.**
- ### **🔥 5.1 Object-Oriented Design for FAANG**
  
  ✅ **Design Principles (SOLID, DRY, KISS, YAGNI, Composition Over Inheritance)**
  
  ✅ **Interface Segregation & Dependency Injection**
  
  ✅ **Applying Design Patterns to Real-World Problems**
- ### **🔥 5.2 FAANG-Level LLD Questions**
  
  🔹 **Design a Parking Lot** → (Use Factory, Singleton, Strategy, Observer)
  
  🔹 **Design a Library Management System** → (Use Factory, Composite, Observer)
  
  🔹 **Design a Hotel Booking System** → (Use Builder, Strategy, State)
  
  🔹 **Design an ATM Machine** → (Use State, Factory, Chain of Responsibility)
  
  🔹 **Design a Logging Framework** → (Use Chain of Responsibility, Factory)
  
  🔹 **Design a Cache System** → (Use Flyweight, Proxy, Decorator)
  
  🔹 **Design an E-commerce Shopping Cart** → (Use Strategy, Observer, Decorator)
  
  🔹 **Design a URL Shortener** → (Use Factory, Singleton)
- ## **🔥 6. LLD Mock Interview Preparation**
  
  1️⃣ **Mock Interviews:** **Implement FAANG LLD problems under time constraints**
  
  2️⃣ **Code Reviews:** **Refactor LLD solutions for scalability & maintainability**
  
  3️⃣ **Real-World Systems:** **Analyze architectures of Uber, Netflix, Amazon**
-