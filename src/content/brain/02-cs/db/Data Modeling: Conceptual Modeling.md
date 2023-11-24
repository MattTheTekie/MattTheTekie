---
title: "Data Modeling: Conceptual Modeling"
---

## 01

### Steps

1. Conceptual: Entity-Relationship Diagram (ERD) or UML Class Diagram.
2. Logical: Tables and relationships originated from the conceptual model.
3. Physical: Tables and relationships with the physical characteristics of the database (indexes, partitions, data types, etc).

## 02

### Entity

According to Heuser (2009), it's the representation of a set of objects from the modelling reality which it's relevant to keep information about in the database.

### Relationship

According to Heuser (2009), it's the property of the entity that specifies the associations between the objects. It corresponds to a set of associations between occurrencies of entities.

### Self-Relationship

Occurs when there's a prerequisite relationship between the entity and itself. For example, in order to course Calculus 2, the student must have passed Calculus 1. That way, there's a self-relation for Discipline entity.

### Cardinality

(min, max) notation. It doesn't change relative to the entity, it's always from left to right and means the participation of the entity in the relationship. (0, n) means it can participate **n** times and also don't participate.

### Attributes

Entities and relationships can have properties that are specified by the attributes. By definition attributes corresponds to a data that is associed with every occurrence of one entity or relationship.

#### Cardinality in Attributes

| Min | Max | Meaning |
| --- | --- | ------- |
| 0 | 1 | Optional, Monovalued |
| 0 | n | Optional, Multivalued |
| 1 | 1 | Mandatory, Monovalued |
| 1 | n | Mandatory, Multivalued |

#### Composed Attributes

An address attribute can be subdivided in street, number, city, state, etc.

### Specialization / Generalization

Let's say we have a Employee entity, but we want to, besides having employees that are not managers, have managers that are also employees.

We can create **a specialization of the Employee entity, called Manager, that will inherit all the attributes of the Employee entity**.

We can also specify attributes that only refers to managers in that way.

Also we could have other specializations, like Analyst, and we could have a Employee that is both a Manager and a Analyst (we can define those rules of wether the specializatins are shared or exclusive).

## 04

### Attribute X Specialization

To decide wether attribute or specialization should be used to represent an object, the criteria is: **if the object has attributes or relationships, then it should be represented by a relationship**.

### Optional Attributes

When an entity has a lot of optional attributes, a closer look is needed to see if any of those attributes is one probable specialization.

### Composed Attributes

It's also common to model composed attributes as entities, for example, an address attribute can be modeled as an Address entity. This way the outcome is less dense.