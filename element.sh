#!/bin/bash
ALTER TABLE properties ADD FOREIGN KEY (atomic_number) REFERENCES elements(atomic_number); 