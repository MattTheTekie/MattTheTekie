---
title: "Python in Other Paradigms"
---

## Functional Language in Python

In functional programming, every action performed by the program must be integrated as a function or a composition of functions, but must follow the following rules:

- Functions must be pure, that is, at any point in the program, they always produce the same result when passed the same parameters;
- Data must be immutable, and once a variable is defined, its value cannot be changed;
- Loops should not be used, but function composition or recursion should be used.

Pure functions should't change data that is outside of it's scope.

### Side Effects

Side effects is exactly what's it is willing to avoid here. Side effect is, for example, when you change a variable inside of the function and a global var was associated with it. Now this global var gets it's value altered and wherever you're using it, it will produce different results.

The main goal of functional programming is avoid side effects.

### Higher Order Functions

In functional programming, it is very common to use functions that accept other functions as parameters or that return another function. These functions are called higher order functions. Example:

```python
def multiply_by(multiplier):
  def multi(multiplying):
    return multiplying * multiplier
  return multi

def main():
  multiply_by_10 = multiply_by(10)
  print(multiply_by_10(1))
```

### Lambda Functions

Python has support for lambda functions (anonymous functions). These are defined without identifier (or name) and are usually used as arguments to other (higher order) functions.

```python
# Consider the function to multiply two numbers below:

def multiply(a, b):
  return a*b

# The equivalent lambda function is:

lambda a, b: a*b
```

### Don't Use Loops

Internal functions or recursion can be used instead of for or while loops. Most common Internal functions are map and filter.

#### Filter

It is used to filter elements of an iterable (list, tuple, dictionaries, etc.). The filter is performed using a function, which must be able to return true or false (true or false) for each element of the iterable.

#### Maps

It is used to iterate through elements of a list and produce a result for each element, returning that way a new list. The new lists value will depend on the function passed, which must be able to return a value for each element of the iterable.

For both internal function cases, is a good approach to use lambda functions since it'll use less code and the declaration is simple.

## Concurrent Programming

### Concept

It is possible to compress a file and continue using the word processor, even on a single-core processor, as the processor divides the usage time between the processes of these two applications. That is: these two applications run concurrently.

While the competition doesn't necessarily need more than one core, it can benefit from having more of them, as the processes don't need to share processor time.

**Parallelism** is a technique to allow programs to run faster by performing multiple operations at the same time. It requires multiple machines or a processor with more than one core. It is also possible to perform parallelism on video cards.

### Threads and Processes

**Threads** are the smallest unit of execution in a program. They are parts of a process. If threads belong to the same process, they share the same memory space and can access the data in an transparent way.

**Processes** are, in other hand, an instance of a program. Each process of a program can execute in different cores of a processor.

### GIL

Before we talk about each approach in Python, let's talk about the global interpreter lock (GIL). In CPython, GIL exists to protect access to language objects.

> In practice, for the same process, the GIL only allows executing one thread at a time, that is, they do not execute in parallel, but concurrently. Without the GIL “lock”, a simple variable assignment operation could generate inconsistent data if two threads assigned a value to the same variable at the same time.

For the processes, in turn, the operation is different. For each, we have a separate GIL.

Multiple processes can run in parallel, while multiple threads (of the same process) can run concurrently.

### What are threads for in Python?

Normally, we use a thread for graphical interface, database access, network access, etc., because the program cannot stop, or the interface freezes, while we wait to download a file, for example.

### Performance

When we have a program that needs a lot of processor resources and we have a way to parallelize our program, we must choose to create multiple processes.

Creating new processes can be slow and memory intensive, while creating threads is faster and consumes less memory.

### Creating Threads and Processes in Python

```python
from threading import Thread
from multiprocessing import Process

def function_a(name):
  print(name)

def main():
  t = Thread(target=function_a, args=("My Thread",))
  t.start()

  p = Process(target=function_a, args=("My Process",))
  p.start()

if __name__ == '__main__':
  main()
```

### Lock

Imagine that we have a function that will increase a list of integers in 1000 new positions and increment it's value. Now, we execute this function in multiple threads. The result expected is to have a list with $1000 \cdot 10$ length. But the result is different.

GIL will guarantee that only one thread will be executed at a time, but it doesn't prevent this situation. For GIL, append is an atomic operation, so it is executed in safety and it's executions can't be stopped. But increment isn't atomic as it will read and write.

That's called **running condition**. To avoid this, we can use a lock. Such an object has only two states: locked and unlocked. When created, it is in an unlocked state. This object has two methods: acquire and release.

When in the unlocked state, the acquire changes its state to locked and returns immediately. When in the locked state, acquire blocks execution until another thread calls the release method and unlocks the object.

```python
from threading import Thread, Lock

def function_a(name, lock):
  lock.acquire()
  print(name)
  lock.release()

def main():
  lock = Lock()
  t = Thread(target=function_a, args=("My Thread", lock))
  t.start()

if __name__ == '__main__':
  main()
```

### Sharing Values Between Processes

We can use Value class from multiprocessing module to share values between processes.

```python
from multiprocessing import Process, Value

def function_a(value):
  value.value += 1

def main():
  value = Value('i', 0) # i is the type of the value and 0 is the initial value
  p = Process(target=function_a, args=(value,))
  p.start()
  p.join()
  print(value.value)

if __name__ == '__main__':
  main()
```

## Web Development with Python

Python can be used to develop web applications. For this purpose, we can use frameworks. There are two types of frameworks in this case: full-stack and non-full-stack. The main full-stack framework is Django, and for non-full-stack frameworks we have Flask and CherryPy.

### Flask

Flask is a microframework for Python. It is very simple and easy to use.

```python
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
  return "Hello world."

if __name__ == '__main__':
  app.run()
```

In the first line, we import the flask class, which is the framework's main class. It is from an instance of this class that we will create our web application. In line 2, an instance of the flask class is created, where we pass __name__ as an argument so that Flask can locate, in the application, static files, such as css and javascript, and template files (templates), if applicable.

The decorator @app.route('/') is used to define the route of the application. In this case, the route is the root of the application. The function hello_world() is the function that will be executed when the route is accessed. The function associated to a route should return something.

### Route Parameters

```python
from flask import Flask
app = Flask(__name__)

@app.route('/user/')
@app.route('/user/<username>')
def show_user_profile(username='Default'):
  return 'User %s' % username

if __name__ == '__main__':
  app.run()
```

We define two routes for the same function. The first route is the root of the application, and the second route is the root of the application followed by a parameter. The parameter is passed to the function as an argument. If the parameter is not passed, the function will use the default value.

### HTTP Methods

```python
from flask import Flask
app = Flask(__name__)

@app.route('/login', methods=['GET', 'POST'])
def login():
  if request.method == 'POST':
    return "POST"
  else:
    return "GET"

if __name__ == '__main__':
  app.run()
```

### Models

Models are html pages with steroids. We can use delimiters to insert dynamic content in the page. The delimiters are {{ }} and {% %}.

```html
<!DOCTYPE html>
<html>
  <head>
    <title>My Page</title>
  </head>
  <body>
    <h1>My Page</h1>
    <p>My name is {{ name }}.</p>
    {% if name == 'John' %}
      <p>My name is John.</p>
    {% else %}
      <p>My name is not John.</p>
    {% endif %}
  </body>
</html>
```

## Data Science with Python

### KDD

KDD (Knowledge Discovery in Databases) by Fayyad, 1996. p. - “KDD is a multi-step, non-trivial, interactive and iterative process for identifying understandable, valid, new and potentially useful patterns from large datasets”

This process, also called data mining, is composed of the following steps: preprocessing, data mining, and post-processing.

### Preprocessing

This step is responsible for select, prepare and transform the data that will be used by the mining algorithms. Some steps of this process are:

- **Collect**;
- **Integrate**;
- **Attribute Construction**;
- **Data Cleaning**;
- **Data Splitting**: train and test;

### Data Mining

For Hand, 2001. p.6 - "Data mining is the analysis of (almost always large) observed datasets to discover hidden relationships and to consolidate the data in such a way that they are intelligible and useful to their owners."

This step is the most important one, since it is responsible for finding the hidden patterns in the data.

> Mining algorithms can be classified as supervised and unsupervised. In the former, the algorithms “learn” based on the values that each piece of data already has. Algorithms are trained (tuned) by applying a function and comparing the result with existing values.
>
> In unsupervised cases, the data were not previously classified and the algorithms try to extract some pattern by themselves.

Unsupervised:
Association rules One of the most used data mining techniques for e-commerce, whose objective is to find rules for products purchased in the same transaction. That is, the presence of a product in a set implies the presence of other products in another set; with this, shopping sites send us additional shopping suggestions, based on what we are buying.
Grouping It brings together, in the same group, objects from a collection that maintain some degree of affinity. A function is used to maximize the similarity of objects of the same group and minimize between elements of other groups.
Supervised:
Classification Aims to discover a function capable of mapping (classifying) an item into one of several predefined classes. If we manage to obtain the function that performs this mapping, any new occurrence can also be mapped, without the need for prior knowledge of its class.
Linear regression It is a technique to estimate a variable from a function. Regression usually aims to find a value that was not computed initially.
// Transform the above text into a table in markdown format, please copilot

| | Unsupervised |
| --- | --- |
| Association rules | One of the most used data mining techniques for e-commerce, whose objective is to find rules for products purchased in the same transaction. That is, the presence of a product in a set implies the presence of other products in another set; with this, shopping sites send us additional shopping suggestions, based on what we are buying. |
| Grouping | It brings together, in the same group, objects from a collection that maintain some degree of affinity. A function is used to maximize the similarity of objects of the same group and minimize between elements of other groups. |
| | <p style="text-align: center; font-weight: bold;">Supervised</p> |
| Classification | Aims to discover a function capable of mapping (classifying) an item into one of several predefined classes. If we manage to obtain the function that performs this mapping, any new occurrence can also be mapped, without the need for prior knowledge of its class. |
| Linear regression | It is a technique to estimate a variable from a function. Regression usually aims to find a value that was not computed initially. |

### Post-processing

The last stage of KDD, post-processing, aims to transform the data patterns obtained in the previous stage, in order to make them intelligible, both to the data analyst and to the specialist in the application domain (SOARES, 2007).

#### Python Data Mining Algorithms

##### Linear Regression - Supervised:

In this example, we will use a fictitious historical series of dengue cases in a given city and, with the aid of the supervised linear regression algorithm, we will predict future cases.

```python
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression
import pandas

############# Preprocessing ###############
# Collection and Integration
file = pandas.read_csv('data_dengue.csv')

years = file[['year']]
cases = file[['cases']]

############## Mining #################
regr = LinearRegression()
regr.fit(X=years, y=cases)

future_year = [[2018]]
cases_2018 = rule.predict(future_year)

print('Cases expected for 2018 ->', int(cases_2018))

############ Post Processing ################
plt.scatter(years, cases, color='black')
plt.scatter(future_year, 2018_cases, color='red')
plt.plot(years, regr.predict(years), color='blue')

plt.xlabel('Years')
plt.ylabel('Dengue cases')
plt.xticks([2018])
plt.yticks([int(2018_cases)])

plt.show()
```

##### Classification - Supervised:

For this example, we will use a dataset created in 1938 and still used today: the Iris Flower dataset. It contains information on fifty samples of three different classes of iris flower (Iris setosa, Iris virginica and Iris versicolor).

We will train two classification algorithms, decision tree and support vector machine (SVM) to assemble two Iris flower classifiers.

```python
from sklearn.datasets import load_iris, fetch_kddcup99
from sklearn.metrics import accuracy_score
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier, export_text, plot_tree
from sklearn.svm import SVC

################## Preprocessing ###################
# Collection and Integration
iris = load_iris()

characteristics = iris.data
labels = iris.target

print("Characteristics:\n", traits[:2])
print("Labels:\n", labels[:2])
print('################################################ #########')

# Partition the data
carac_train, carac_test, rot_train, rot_test = train_test_split(characteristics, labels)

################### Mining #####################

############---------- Decision tree -----------############
tree = DecisionTreeClassifier(max_depth=2)
tree.fit(X=carac_train, y=rot_train)

rot_predicts = tree.predict(test_character)
tree_accuracy = accuracy_score(test_rot, predicted_rot)
############-------- Vector Machine Support ------############
clf = SVC()
clf.fit(X=character_training, y=rot_training)

rot_predicts_svm = clf.predict(test_character)
accuracy_svm = accuracy_score(test_rot, svm_predicted_rot)

################ Post Processing #####################
print("Decision Tree Accuracy:", round(tree_accuracy, 5))
print("SVM Accuracy:", round(svm_accuracy, 5))
print('################################################ #########')

r = export_text(tree, feature_names=iris['feature_names'])
print("Tree structure")
print(r)
```

**Tip**: To separate the samples into training and testing, Scikit-Learn provides a function called train_test_split, which receives a list of characteristics as its first parameter and a list of labels as its second parameter.

This function returns four new lists: **Training, Features test, Training, Label test**.

##### Grouping - Unsupervised:

> The purpose of a clustering algorithm is to gather objects from a collection that maintain some degree of affinity. A function is used to maximize the similarity of objects of the same group and minimize between elements of other groups.

In the next example (grouping.py script), we will use the k-medias algorithm to generate groups from the Flor de Iris dataset. However, since clustering is an unsupervised algorithm, we will not use the labels to train it. The algorithm will automatically separate the samples into groups, which will be visualized in a graph.

```python
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from sklearn.cluster import KMeans
from sklearn.datasets import load_iris

################## Preprocessing ###################
# Collection and Integration
iris = load_iris()

characteristics = iris.data

################### Mining #####################
groups = KMeans(n_clusters=3)
groups.fit(X=characteristics)
labels = groups.labels_ # index of the group to which each sample belongs

################ Post Processing #####################
fig = plt.figure(1)
ax = Axes3D(fig)
ax.set_xlabel('Sepal Length')
ax.set_ylabel('Sepal Width')
ax.set_zlabel('Petal Length')
ax.scatter(features[:, 0], characteristics[:, 1], characteristics[:, 2], c=groups.labels_, edgecolor='k')

target = iris.target
fig = plt.figure(2)
ax = Axes3D(fig)
ax.set_xlabel('Sepal Length')
ax.set_ylabel('Sepal Width')
ax.set_zlabel('Petal Length')
ax.scatter(features[:, 0], characteristics[:, 1], characteristics[:, 2], c=target, edgecolor='k')

plt.show()
```

# Footer

- **Class**: Paradigms and Python Lang
- **Theme**: Python In Other Paradigms