## Clock Domain Crossing (CDC)

- In a design with multiple clocks, **clock domain crossing** occurs whenever data is transferred from a flip-flop driven by one clock to a flip-flop driven by another clock.
- When the signal is sampled in another clock domain and there is any **setup and hold time violation**, the receiving register may become **metastable**, and the output can settle to a random value after an **unknown amount of time**.

### What Are Clock Domains?

A **clock domain** is a portion of a digital circuit that operates using the same clock signal.  
When signals cross between different clock domains, **special care** must be taken to ensure reliable data transfer.

### Key CDC Synchronization Techniques

#### 1. Double Flop Synchronizer

This is the most common technique for **single-bit signals**.  
It uses **two or more flip-flops in series** to resolve metastability and ensure stable data capture in the receiving domain.



