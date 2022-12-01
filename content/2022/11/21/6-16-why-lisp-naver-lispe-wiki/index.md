---
title: "为什么选择 Lisp?"
date: 2022-11-21T23:47:01+08:00
updated: 2022-11-21T23:47:01+08:00
taxonomies:
  tags: []
extra:
  source: https://github.com/naver/lispe/wiki/6.16-Why-Lisp
  hostname: github.com
  author: naver
  original_title: "Why Lisp"
  original_lang: en
---

_Lisp_ is not dead. For a language born at the end of the 50's, this is a happy but also very surprising fact. The success of [_Clojure_](https://clojure.org/) or the remarkable resistance of [_Common Lisp_](https://fr.wikipedia.org/wiki/Common_Lisp) represent a kind of anomaly in a world dominated by _javascript_ and _Python_... By the way, _javascript_ is in fact a _Lisp_ in disguise.

_Lisp_ 并没有死。 对于一门诞生于 50 年代末的语言来说，这是一个令人高兴但也非常令人惊讶的事实。 的成功 [_Clojure_](https://clojure.org/) 的显着抵抗 [_或 Common Lisp_](https://fr.wikipedia.org/wiki/Common_Lisp) 主导的世界中的一种反常现象 _代表了在由 javascript_ 和 _Python_ ……顺便说一句， _javascript_ 实际上是伪装的 _Lisp_ 。

Well, _Lisp_ is not dead, and since the _proof has to be in the pudding_, we will show how our own [_LispE_](https://github.com/naver/lispe) interpreter was implemented.

好吧， _Lisp_ 并没有死，既然 _证明必须在布丁_ 中，我们将展示我们自己的 [_LispE_](https://github.com/naver/lispe) 解释器是如何实现的。

But the question can be asked, how does a prefixed language, drowned in parentheses, still attract so much interest?

但是可以问一个问题，一种淹没在括号中的带前缀的语言如何仍然引起如此多的兴趣？

## _Lisp_ is a philosophy

## _Lisp_ 是一种哲学

_Lisp_ is not only one of the oldest languages still in use, but also one of the very first _functional languages_ ever invented.

_Lisp_ 不仅是仍在使用的最古老的语言之一，而且还是最早发明的 _函数式语言_ 之一。

_Lisp_ is _homoiconic_. That is, the language is stored in the form of lists, which are also a basic data structure of the language. This makes the language extraordinarily malleable, as this [example](https://github.com/naver/lispe/wiki/6.13-Create-your-own-language-with-a-lot-of-transpiling:-in-LispE) shows.

_Lisp_ 是 _谐音_ 的。 即语言以列表的形式存储，也是语言的一种基本数据结构。 正如这个 [例子](https://github.com/naver/lispe/wiki/6.13-Create-your-own-language-with-a-lot-of-transpiling:-in-LispE) 所示，这使得语言具有非凡的可塑性。

Finally, there are few programming languages as easy to implement as _Lisp_.

最后，很少有编程语言像 _Lisp_ 一样易于实现。

There are two very paradoxical reasons for this.

这有两个非常矛盾的原因。

### The parentheses

### 括号

Let's take an aspect of the language that often stings the eyes of newbies: the _infamous parentheses_ that the language seems to abuse. Yes, _Lisp_ uses these parentheses heavily and they sometimes make the language a bit obscure. But as _Lisp_ programmers often point out, this is a bit of an illusion:

让我们来看看经常刺痛新手眼睛的语言的一个方面： _的臭名昭着的括号_ 该语言似乎滥用 。 是的， _Lisp_ 大量使用这些括号，它们有时会使语言有点晦涩难懂。 但正如 _Lisp_ 程序员经常指出的那样，这有点像幻觉：

```lisp
(sin 10); Lisp
sin(10); Other language
```

### Prefixed notation

### 前缀符号

Before we embark on yet another defense of the language along the lines of: _parentheses in Lisp are great, but only insiders can understand them_. Let's notice a second element that often confuses those who learn the language: in _Lisp everything is prefixed_.

在我们开始对语言进行另一次辩护之前： _Lisp 中的圆括号很棒，但只有业内人士才能理解它们_ 。 让我们注意第二个经常让学习该语言的人感到困惑的元素：在 _Lisp 中，一切都带有前缀_ 。

Here we have the two most common complaints: _parentheses and prefixed notation_. And to top it all off, we also have our answer to what makes building a _Lisp_ interpreter a bit of an easy ride. Well, compared to other languages, that is.

这里我们有两个最常见的抱怨： _括号和前缀符号_ 。 最重要的是，对于是什么让构建 _Lisp_ 解释器变得如此轻松，我们也有了自己的答案。 好吧，与其他语言相比，就是这样。

## Compiling _Lisp_

## 编译 _Lisp_

So here is this strange paradox which makes the highly parenthetized prefixed form of _Lisp_ both the reason for rejecting the language but also for its simplicity to create interpreters to run it.

所以这是一个奇怪的悖论，它使得 _Lisp_ 的高度括号前缀形式既是拒绝该语言的原因，也是因为它创建解释器来运行它的简单性。

And all this is based on a fundamental notion in compilation theory: _the abstract syntax tree_.

而这一切都基于编译理论中的一个基本概念： _抽象语法树_ 。

### The Abstract Syntax Tree (_AST_)

### 抽象语法树 ( _AST_ )

One of the most important steps, when compiling a sequence of instructions in a language like _Python_ or _C++_, is to reduce everything to trees.

等语言编译指令序列时，最重要的步骤之一 _在使用 Python_ 或 _C++_ 是将所有内容简化为树。

The reason for this is very simple, a tree is the best way to express the relationships that the different objects have with each other in a program:

原因很简单，树是表达程序中不同对象之间关系的最佳方式：

Generally, a compiler or interpreter takes the above expression and puts it through a series of transformations:

通常，编译器或解释器采用上述表达式并对其进行一系列转换：

- tokenization
- 代币化
- reorganization in the form of a tree via a formal grammar (BNF)
- 通过形式语法 (BNF) 以树的形式重组

Tokenization as its name indicates consists in cutting the string into as many autonomous units (_tokens_):

顾名思义，标记化包括将字符串切割成尽可能多的自治单元（ _标记_ ）：

```python
toto=10 + a-20 # becomes: toto,=,10,+,a,-,20
```

This operation in _Lisp_ is even easier than in a language like _Python_. Indeed, in most languages, tokenisation is done along the operators, spaces are rarely enough.

中的此操作 _Lisp_ 甚至比 _Python_ 等语言更容易。 事实上，在大多数语言中，标记化是沿着操作符完成的，空间很少是不够的。

In _Lisp_, tokenisation is reduced to identifying parentheses and spaces.

在 _Lisp_ 中，标记化被简化为识别括号和空格。

```lisp
(setq toto (- (+ 10 a) 20)); becomes (,setq,toto,(,-,(,+,10,a,),20,),)
```

But above all, the fundamental difference is the construction of the tree. If we take our _Python_ expression, the corresponding tree is as follows:

但最重要的是，根本的区别在于树的构造。 如果我们采用我们的 _Python_ 表达式，对应的树如下所示：

```
                 =
               /   \
             toto   -
                   / \
                  +  20
                 / \
                10  a
```

This is the result of applying a grammar that might look like this:

这是应用可能如下所示的语法的结果：

```
assignment :: name = expression|variable
expression :: value|variable operator variable|expression
```

We will now perform a prefixed walk:

我们现在将执行前缀遍历：

We will add parentheses to this prefixed walk, as follows, each non-terminal subtree will be injected between parentheses:

我们将在这个带前缀的遍历中添加括号，如下所示，每个非终端子树将被注入到括号之间：

```
(=)
(= toto)
(= toto (-))
(= toto (- (+)))
(= toto (- (+ 10)))
(= toto (- (+ 10 a)))
(= toto (- (+ 10 a) 20))
```

So, this parenthetical representation is in every way similar to _Lisp_. And this is not by chance.

So, this parenthetical representation is in every way similar to _Lisp_. And this is not by chance.

McCarthy's initial project consisted in integrating into _Fortran_ symbolic expressions strongly inspired by Church's _lambda-calculus_ theory: the _M-expressions_. However, it soon turned out that the intermediate step called [S-expressions](https://arxiv.org/abs/1505.07375) was much simpler to implement.

McCarthy's initial project consisted in integrating into _Fortran_ symbolic expressions strongly inspired by Church's _lambda-calculus_ theory: the _M-expressions_. However, it soon turned out that the intermediate step called [S-expressions](https://arxiv.org/abs/1505.07375) was much simpler to implement.

If we add that the construction and application of grammars to reconstruct such a tree is far from trivial, we quickly understand how much the _Lisp_ expressions avoid to a designer all the heavy architecture of traditional languages.

If we add that the construction and application of grammars to reconstruct such a tree is far from trivial, we quickly understand how much the _Lisp_ expressions avoid to a designer all the heavy architecture of traditional languages.

### Prefixed

### Prefixed

Finally, let's add that the systematic prefixed representation for operators and functions also greatly simplifies code compilation.

Finally, let's add that the systematic prefixed representation for operators and functions also greatly simplifies code compilation.

Remember for example that in _Python_, calling a function or writing a mathematical expression obey different rules. We are so used to manipulating these expressions, that we forget that this difference in syntax has a cost:

请记住，例如在 _Python_ 中，调用函数或编写数学表达式遵循不同的规则。 我们习惯于操纵这些表达式，以至于忘记了这种语法差异是有代价的：

```python
toto = 10 + a - 20
titi = sin(a)
```

Indeed, we need different entry points in our grammar to understand each of these expressions.

事实上，我们的语法需要不同的入口点来理解这些表达式中的每一个。

If we compare these expressions to _Lisp_:

如果我们将这些表达式与 _Lisp_ 进行比较：

```lisp
(setq toto (- (+ 10 a) 20))
(setq titi (sin a))
```

You can immediately see the difference, in _Lisp_ everything is a function, including operators. Thus, the compilation of numerical expressions or function calls is unified in the same formalism.

你可以立即看出区别，在 _Lisp_ 中一切都是函数，包括运算符。 因此，数值表达式或函数调用的编译被统一在同一个形式体系中。

In a way, _Lisp_ forces the user to do some of the compilation work, where other languages apply heavy grammars to build these _S-expressions_. But, it also removes many ambiguities that sometimes lead to bugs.

在某种程度上， _Lisp_ 强迫用户做一些编译工作，而其他语言使用繁重的语法来构建这些 _S 表达式_ 。 但是，它也消除了许多有时会导致错误的歧义。

Just compare:

只是比较：

with the unambiguous form:

具有明确的形式：

```lisp
(setq toto (- 10 (* 2 10))
```

### Uniformity of syntax

### 句法统一

The other advantage of _Lisp_ is that there is no need to invent different programming styles to integrate new features.

的另一个优点 _Lisp_ 是无需发明不同的编程风格来集成新功能。

_Python_ offers particularly striking examples of this:

_Python_ 提供了特别引人注目的例子：

```python
fruits = ["apple", "pear", "banana", "strawberry"]
v = [x for x in fruits if "a" in x]
```

Note that we have chosen _Python_ as our comparison language, because it has the advantage of being simple and popular. Remember that most of these remarks could be applied to languages like _C++_ or _Java_.

请注意，我们选择 _Python_ 作为我们的比较语言，因为它具有简单和流行的优点。 请记住，这些评论中的大部分都适用于 _C++_ 或 _Java_ 等语言。

Thanks to its syntactic uniformity, _Lisp_ does not need to reinvent the wheel to implement the above example:

由于其句法统一性， _Lisp_ 不需要重新发明轮子来实现上面的例子：

Here is how we could translate this expression into _LispE_:

下面是我们如何将这个表达式翻译成 _LispE_ ：

```lisp
(setq fruits '("apple" "pear" "banana" "strawberry"))
(setq v (filterlist (λ(x) (in x "a")) fruits))
```

As we can see, the syntax remains the same.

正如我们所见，语法保持不变。

Moreover, if we stay in the realm of legend, when engineers were asked to produce, in a few days, a new language for the Web, their first version looked like _Lisp_. Which the managers disliked, so they were asked to correct their copy, which gave the version of _javascript_ that we know today.

此外，如果我们停留在传奇领域，当工程师被要求在几天内开发一种新的 Web 语言时，他们的第一个版本看起来像 _Lisp_ 。 经理们不喜欢，所以他们被要求更正他们的副本，这给了 _的 javascript 版本。_ 我们今天所知道

The interest of _Lisp_ is that it makes it possible to experiment with new operators or new features without having to re-implement the language grammar each time. Many concepts in computer science, starting with object programming, started with implementations in _Lisp_.

的有趣之 _Lisp_ 处在于，它可以在不必每次都重新实现语言语法的情况下试验新的运算符或新的特性。 计算机科学中的许多概念，从对象编程开始，都是从 _Lisp_ 中的实现开始的。

## Lisp is my guide

## Lisp 是我的向导

As I said before, _Lisp_ is a philosophy. It is a way of representing and executing programs in an intermediate form between man and machine. The _S-expressions_ offer a very elegant way of representing _code and data_ in the same syntax.

正如我之前所说， _Lisp_ 是一种哲学。 它是一种以人机之间的中间形式表示和执行程序的方式。 的非常优雅的方式。 _S 表达式_ 提供了一种 _表示代码和数据_ 以相同语法

Could this be used in other languages?

这可以用于其他语言吗？

### Is Object Oriented Programming soluble in Lisp?

### 面向对象编程可溶于 Lisp 吗？

I program in _C++_.

我用 _C++ 编程_ 。

I know that the language has a bad reputation and some people advised me to switch to _Rust_. But, after 30 years of practice, I feel I have a certain familiarity with a language whose performances are no longer to be demonstrated.

我知道该语言名声不好，有些人建议我改用 _Rust_ 。 但是，经过 30 年的实践，我觉得我对一门表演不再需要展示的语言有了一定的熟悉。

Because of course, when you make your own interpreter, you expect a certain efficiency in terms of compilation and execution. _C++_ allows you to tickle the processor at the edge of the metal while manipulating very high level abstractions. But the price to pay is sometimes quite heavy, because the language is tortuous and often tricky, not to say _deceitful_.

因为当然，当你制作自己的解释器时，你期望在编译和执行方面有一定的效率。 _C++_ 允许您在处理非常高级别的抽象时让处理器处于金属边缘。 但是付出的代价有时是相当沉重的，因为语言是曲折的，而且往往是刁钻的，更不用说 _欺骗_ 了。

The purpose of this blog is to show how one can build a [_Lisp_](https://github.com/naver/lispe) interpreter in _C++_, which is directly inspired by the _functional philosophy of Lisp_.

这个博客的目的是展示如何 [_中构建一个 Lisp_](https://github.com/naver/lispe) 解释器 _在 C++_ ，它直接受到 _Lisp 函数哲学的_ 启发。

It's like _putting the code into a programmatic abyss_ in a way...

这就像 _以某种方式将代码放入编程深渊_ ......

### So what is this mysterious link between _Lisp_ and OOP?

### 那么 _Lisp_ 和 OOP 之间的神秘联系是什么？

First of all, let's start with a banality: whether you practice functional programming or any other form of programming, your program will end up as machine code with lots of _jumps_ in all corners.

首先，让我们从一个平庸的话题开始：无论您练习函数式编程还是任何其他形式的编程，您的程序最终都将成为机器代码， _都有很多跳转。_ 在各个角落

I know, it's sad but that's the way it is. It's a bit like seeing a painting by a great Renaissance master. From a distance, it looks smooth and shiny, when you get closer, you see the brush strokes.

我知道，这很可悲，但事实就是如此。 这有点像看到文艺复兴时期伟大大师的画作。 从远处看，它看起来光滑而有光泽，当你走近时，你会看到笔触。

Anything you can program in one general purpose language, you must be able to program in another general purpose language. This is the conclusion of the famous [Turing paper](https://fr.wikipedia.org/wiki/Th%C3%A8se_de_Church) where he explains that his machine and Alonzo Church's lambda-calculus are equivalent.

任何你可以用一种通用语言编程的东西，你必须能够用另一种通用语言编程。 这是著名的 [图灵论文](https://fr.wikipedia.org/wiki/Th%C3%A8se_de_Church) 的结论，他解释说他的机器和阿朗佐丘奇的 lambda 演算是等价的。

Without this equivalence, functional languages could not exist.

没有这种等价性，函数式语言就不可能存在。

This does not mean that these languages are useless, on the contrary, we can reach programs of a rare sobriety and solidity within this paradigm. But basically, they exist because they can be compiled in an imperative form.

这并不意味着这些语言没有用，相反，我们可以在这种范式中达到罕见的清醒和稳固的程序。 但基本上，它们存在是因为它们可以以命令形式编译。

But conversely, the most powerful functional concepts can also be transcribed into more traditional languages:

但反过来，最强大的功能概念也可以转录成更传统的语言：

```c
long factorial(long x) {
 if (x==1)
    return 1;
 else
    return x * factorial(x - 1);
```

In other words, we can design a _C++_ programming which is inspired by _Lisp_.

换句话说，我们可以设计一个 _启发的 C++_ 程序 _受 Lisp_ 。

And it has some advantages...

它有一些优点......

### The list

### 名单

The basic representation of _Lisp_, the one that has always defined the language and that lies at the heart of its name is the _list_ (LISP = _LIST Processing_).

的基本表示， _Lisp_ 一直定义语言并且位于其名称核心的是 _列表_ （LISP = _LIST Processing_ ）。

There are many ways to create lists in C++, but for now we will settle for the simplest form available: _vector_.

在 C++ 中创建列表的方法有很多种，但现在我们将选择最简单的可用形式： _向量_ 。

However, and this is obviously the heart of the matter, a vector in C++ can only be declared for a given type:

然而，这显然是问题的核心，C++ 中的向量只能为给定类型声明：

```c
std::vector<Element*> elements;
```

However, a list in _Lisp_ can hold any type of elements, including values, operators and function calls.

然而， _Lisp_ 中的列表可以包含任何类型的元素，包括值、运算符和函数调用。

For our vector to offer the same flexibility, experienced readers will have immediately guessed that it is sufficient that all objects in the language _derive_ from the _Element_ class.

为了让我们的向量提供相同的灵活性，有经验的读者会立即猜到语言中的所有对象 _派生就足够了。_ 都从 _Element_ 类

Thus, if we derive from _Element_, an _Operator_ class or an _Integer_ class, we will be able to store operators or integers in the same structure. If moreover, we derive the _List_ class from _Element_, we can then build embedded representations without any limit.

因此，如果我们从 _Element_ 、 _Operator_ 类或 _Integer_ 类派生，我们将能够在同一结构中存储运算符或整数。 派生 _List_ 类 _此外，如果我们从 Element_ ，我们就可以无限制地构建嵌入式表示。

#### The _Eval_ function

#### \_ _评估_ 函数

There is just one missing element to complete our description: each derived class will have to override its own _Eval_ method.

只缺少一个元素来完成我们的描述：每个派生类都必须覆盖它自己的 _Eval_ 方法。

In the case of an integer or a string, this method will return the element itself, for a function or an operator, their _Eval_ method will perform the corresponding execution.

对于整数或字符串，该方法将返回元素本身，对于函数或运算符，它们的 _Eval_ 方法将执行相应的执行。

Here is, for example, the main execution loop of a program:

例如，这是一个程序的主执行循环：

```c
Element* v = null_;
for (const auto& e : elements) {
   v->release()
   v = e->Eval();
}

return v;
```

Note the _release_ method which cleans up the element when it is not used within a variable or a container. The life cycle of a data structure is based on the use of a reference counter. When this counter has the value 0, _release_ cleans up this structure.

请注意 _release_ 方法，它会在元素未在变量或容器中使用时清除该元素。 数据结构的生命周期基于引用计数器的使用。 当这个计数器的值为 0 时， _release_ 清理这个结构。

### Lisp-like architecture

### 类 Lisp 架构

Let's take a closer look at this _Eval_ function:

让我们仔细看看这个 _Eval_ 函数：

We first initialize `v` with the value `null_`, a constant value that cannot be destroyed. Thus, calling `release` here will have no effect on this variable at the entry of the loop.

我们先初始化 `v`与价值 `null_`，一个不能被破坏的常数值。 因此，调用 `release`here 将不会影响循环入口处的此变量。

Then we call the `Eval` method for each of the elements of the vector whose result is stored in `v`.

然后我们调用 `Eval`结果存储在向量中的每个元素的方法 `v`.

And this is where things get interesting. Each value in the interpreter is associated with a reference counter which increases by 1 when that value is stored in a variable or container. When a function is called that returns a result, two things can happen:

这就是事情变得有趣的地方。 解释器中的每个值都与一个引用计数器相关联，当该值存储在变量或容器中时，该计数器加 1。 当调用返回结果的函数时，可能会发生两件事：

- The value comes from the application of a function
- 值来自函数的应用
- The value was returned by a variable or a container
- 该值由变量或容器返回

Now if we look closely at the loop, we see that the value of `v` is _systematically_ released at each iteration, _except_ for the last statement in `elements`. For values saved in a variable or a container, the call of this function has no impact. For the others, it destroys them or saves them in data pools.

现在，如果我们仔细观察循环，我们会发现 `v`中 _系统地_ 在每次迭代 _发布，除了_ 中的最后一条语句 `elements`. 对于保存在变量或容器中的值，调用此函数没有影响。 对于其他人，它会销毁它们或将它们保存在数据池中。

This mode of operation is directly inspired by functional programming:

这种操作模式直接受到函数式编程的启发：

`Each function returns one and only one value whose life cycle is decided locally.`

`Each function returns one and only one value whose life cycle is decided locally.`

If this value is not saved in a variable or in a container, it will be _released_ in the loop at the next iteration, otherwise it will be returned.

如果这个值没有保存在变量或容器中，则 _在下一次迭代时在循环中释放_ ，否则返回。

**Note** that _release_ means that the value is either destroyed or stored in a value pool for later reuse.

**请注意** ， _释放_ 意味着该值要么被销毁，要么存储在一个值池中供以后重用。

In _Lisp_, this is exactly what a function call does:

在 _Lisp_ 中，这正是函数调用的作用：

```lisp
; the last line will return the final calculation
(defun calculus(x)
  (setq x (* x 2))
  (+ x 1)
)
```

What is fundamental in this approach is that the management of the returned values is purely local, there are _no side effects_. More exactly, if the value is not saved in any structure, its release in this loop can be done without any problem, it will have no impact elsewhere in the code.

这种方法的根本是返回值的管理是纯本地的， _没有副作用_ 。 更确切地说，如果值没有保存在任何结构中，它在这个循环中的释放可以毫无问题地完成，它不会影响代码的其他地方。

Organizing the code in this way makes it possible to control step by step the life cycle of all data structures in memory. At each stage of the execution, data structures that are not stored in variables or containers can be safely _released_, even if the execution is done in a _thread_.

以这种方式组织代码，可以逐步控制所有数据结构在内存中的生命周期。 中执行，也可以安全地 _释放_ 在执行的每个阶段，即使是在 _线程_ 未存储在变量或容器中的数据结构。

Thus, in the execution of: `(* 10 (+ 20 1) (- 15 1))`, the intermediate values `(+ 20 1)` or `(- 15 1)` will be used by the multiplication but _released_ at the end:

因此，在执行： `(* 10 (+ 20 1) (- 15 1))`, 中间值 `(+ 20 1)`或者 `(- 15 1)`将被乘法使用但 _在最后释放_ ：

```c
long value = 1;
Element* v;
for (Element* e : elements) {
   v = e->Eval();
   value *= v->asNumber();
   v->release();
}

return new Integer(value);

```

The above loop for example performs the multiplication of the integers in `elements`. At each iteration, the `v` that come from an intermediate calculation, are _released_.

例如，上面的循环执行整数乘法 `elements`. 在每次迭代中， `v`来自中间计算的，被 _释放_ 。

Thus, we make sure that at each step, nothing is left in the memory space. Note that the final result of this loop is an intermediate object which can also be destroyed when calling this function.

因此，我们确保在每一步中，内存空间中都没有留下任何东西。 请注意，此循环的最终结果是一个中间对象，在调用此函数时也可以将其销毁。

### Immutability

### 不变性

The other fundamental aspect of this architecture is that the objects, corresponding to instructions, _are by definition immutable_. In other words, the same object can be executed as many times as necessary without it ever being modified.

该体系结构的另一个基本方面是， _根据定义，与指令相对应的对象是不可变的_ 。 换句话说，同一对象可以根据需要多次执行，而无需修改。

Finally, the execution of these instructions is done outside a virtual machine, since each object _necessarily_ knows how to execute.

最后，这些指令的执行是在虚拟机之外完成的，因为每个对象都 _必须_ 知道如何执行。

Thus, we find in this approach, the fundamental properties of functional programming.

因此，我们在这种方法中发现了函数式编程的基本属性。

- Everything is a function call (here reduced to an _Eval_ call for each object)
- 一切都是函数调用（这里简化为 _的 Eval 调用）_ 对每个对象
- Immutability of objects
- 对象的不变性
- No side effects.
- 无副作用。

### Threads

### 线程

This mechanism makes it very easy to create independent _threads_ which can execute the same functions in parallel. In fact, you only need to launch the _Eval_ function on an object for it to run.

变得非常容易 _独立线程_ 这种机制使得创建可以并行执行相同功能的 。 事实上，您只需要在一个对象上启动 _Eval_ 函数，它就会运行。

This is the most important difference with more traditional methods where instructions are translated into pseudo-code and executed by a virtual machine. For example, _Python_ can only execute one virtual machine at a time, which restricts the possibility of writing threads, since they are all executed in the same space protected by the famous _GIL_ (Global Interpreter Lock). _Python_ can execute threads but one at a time.

这是与更传统的方法最重要的区别，在传统方法中，指令被翻译成伪代码并由虚拟机执行。 例如， _Python_ 一次只能执行一个虚拟机，这限制了编写线程的可能性，因为它们都在受著名的 _GIL_ （全局解释器锁）保护的同一空间中执行。 _Python_ 一次只能执行一个线程。

Note that in our case, _threads arguments_ are always duplicated at launch, which removes any needs to protect data from concurrent access. However, we still provide a mechanism to make it possible to share some [values across _threads_](https://github.com/naver/lispe/wiki/6.3-Threads).

请注意，在我们的例子中， _线程参数_ 在启动时总是重复的，这消除了保护数据免受并发访问的任何需要。 但是，我们仍然提供一种机制，使 [跨 _线程_](https://github.com/naver/lispe/wiki/6.3-Threads) 共享一些值成为可能。

### OOP + Functional

### 面向对象+功能

On the other hand, object programming simplifies a lot some aspects that are sometimes very complex to master. For example, the addition of objects of different types is a very difficult problem to manage and _Python_ is no exception to the rule, just have a look at the implementation of `__add__` to be convinced.

另一方面，对象编程简化了很多有时非常复杂而难以掌握的方面。 例如，添加不同类型的对象是一个非常难以管理的问题， _Python_ 也不例外，看看实现 `__add__`被说服。

```lisp
(+ 10 20 30) ; returns an integer
(+ 10.1 2.109) ; returns a float
```

In our case, this problem is actually very simple to solve.

在我们的案例中，这个问题其实很容易解决。

The _Element_ class contains the list of basic numerical methods of the language:

： _Element_ 类包含该语言的基本数值方法列表

```c
virtual Element* plus(Element* e);
virtual Element* minus(Element* e);
virtual Element* multiply(Element* e);
virtual Element* divide(Element* e);
```

So for the _Integer_, _Floating_ or _String_ classes, you just have to overload them to get the desired behavior.

因此，对于 _Integer_ 、 _Floating_ 或 _String_ 类，您只需重载它们即可获得所需的行为。

#### List of instructions

#### 使用说明一览

As we said before, our implementation is based on the use of a vector of elements. This element vector has the following form:

正如我们之前所说，我们的实现是基于元素向量的使用。 该元素向量具有以下形式：

```c
std::vector<Elements*> list;
```

Taking our example again: `(+ 10 20 30)`, it could be compiled into the following form:

再次以我们的例子为例： `(+ 10 20 30)`，可以编译成如下形式：

```c
list: [Operator(+), Integer(10), Integer(20), Integer(30)]
```

_Operator_ and _Integer_ are instances of classes derived from: _Element_.

_Operator_ 和 _Integer_ 的类的实例 _是派生自 Element_ 。

Let's override the `plus` method in our _Index_ class:

让我们覆盖 `plus`中的方法： _Index_ 类

```c
class Integer : public Element {
public:
  long value;

  Element* plus(Element* e) {
     long v = value;
     v += e->asInteger();
     return new Integer(v);
  }

  long asInteger() {
     return value;
  }
};
```

The `plus` method makes it possible to set the behavior of the addition for a particular type of object. Now we have to define the `+` operator within a list.

这 `plus`方法可以为特定类型的对象设置加法的行为。 现在我们必须定义 `+`列表中的运算符。

This gives us the method: `eval_plus` below:

这给了我们方法： `eval_plus`以下：

```c
   Element* List::eval_plus() {
        //The element in position 0 is actually our "plus" operator.
        //We get the first element of our list of instructions at position 1
        Element* r = list[1]->Eval();
        Element* v;
        Element* inter;
        for (long i = 2; i < size(); i++) {
          v = list[i]->Eval();
          inter = r->plus(v);
          v->release();
          if (r != inter) {
             r->release();
             r = inter;
          }
        }
        return r;
   }
```

Note that the first data item (_in position 1_) will define the type of addition desired. Thus, if the list starts with an integer, the result will be a sum of integers at the end of the analysis. In the case of a string, it will be a concatenation.

请注意，第一个数据项（ _在位置 1 中_ ）将定义所需的添加类型。 因此，如果列表以整数开头，则结果将是分析结束时的整数之和。 在字符串的情况下，它将是一个连接。

The first element of the list (_at position 0_) is therefore the operator: `Operator(+)`. So we can easily imagine a mechanism, for example a `switch/case` that makes it possible to launch this particular method:

因此，列表的第一个元素（ _位置 0_ ）是运算符： `Operator(+)`. 所以我们可以很容易地想象出一种机制，例如 `switch/case`这使得启动这个特定方法成为可能：

```c
Element* List::Eval() {
   switch (list[0]->label()) {
     case l_cons:
          return eval_cons();
     ...
     case l_plus:
        return eval_plus();
}
```

So, each time the _Eval_ method is executed from a _List_ object, we will be able to execute the function placed at position 0 in our list.

因此，每次 _对象执行 Eval_ 方法 _从 List_ 时，我们将能够执行位于列表中位置 0 的函数。

And here is where the whole operation is revealed. If an instance in the list is an atomic value, `Eval` will return the instance itself. If, on the other hand, it is a list, we will recursively call the method above which will return the corresponding result.

这就是揭示整个操作的地方。 如果列表中的实例是原子值， `Eval`将返回实例本身。 另一方面，如果它是一个列表，我们将递归调用上面的方法，该方法将返回相应的结果。

This representation corresponds point by point to our list in _Lisp_. We just have to launch `Eval` from the root of this list to execute our whole program.

这种表示逐点对应于我们在 _Lisp_ 中的列表。 我们只需要启动 `Eval`从这个列表的根开始执行我们的整个程序。

#### Extensions

#### 扩展

Extending the language is simply a matter of deriving the _Element_ class and overloading the corresponding necessary methods. Thus, if we create a _Date_ class, we will be able to define an addition or a subtraction specific to date management.

扩展语言只是简单地派生 _Element_ 类并重载相应的必要方法。 因此，如果我们创建一个 _Date_ 类，我们将能够定义特定于日期管理的加法或减法。

## Conclusion

## 结论

First, I want to stress how efficient the _interpreter_ produced with this method is, as illustrated with this [experiment](https://github.com/naver/lispe/wiki/2.5--LispE-vs.-Python:-A-Stochastic-Gradient-Descent-Comparison).

首先，我想强调用这种方法生成的 _解释器_ 的效率如何，如本 [实验](https://github.com/naver/lispe/wiki/2.5--LispE-vs.-Python:-A-Stochastic-Gradient-Descent-Comparison) 所示。

Some people might complain that _Lisp_ is too much of a niche language to engage in the effort of understanding how it was implemented. However, what is really important in this article is that, if you create your own syntax and implement a grammar to turn it into a _tree_, you can use the underlying interpreter code in _C++_ without any real modification. In fact, we have also implemented another programming language: [_TAMGU탐구_](https://github.com/naver/tamgu), which follows the same philosophy and still implements a language that is very similar to _Python_.

有些人可能会抱怨 _Lisp_ 是一种过于小众的语言，无法参与了解它是如何实现的。 然而，本文真正重要的是，如果您创建自己的语法并实现一个语法以将其变成 _树_ 中的底层解释器代码 _即可使用 C++_ ，则无需任何实际修改 。 事实上，我们还实现了另一种编程语言： [_TAMGU탐구_](https://github.com/naver/tamgu) 非常相似的语言 _，它遵循同样的理念，仍然实现了一种与 Python_ 。

_Lisp_ might sound like some old language lost in the dark age of computer science, but when you implement a _Lisp_ interpreter, what you actually create is a universal interpreter, which can run many of the programming languages in the world...

_Lisp_ 听起来像是计算机科学黑暗时代中失传的古老语言，但当您实现 _Lisp_ 解释器时，您实际上创建的是一个通用解释器，它可以运行世界上的许多编程语言......

All you need is a tree...

你只需要一棵树...

_And that's very cool, indeed..._

_这真的很酷，真的......_
