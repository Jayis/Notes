# Recommendation Systems with TensorFlow on GCP (scratch)
## Intro
Recommendation systems are not just about suggesting products to users. Sometimes they can be about suggesting users for products. For example, in marketing applications, you may have a new promotion and you want to find the thousand most relevant, current customers. That's called targeting.

recommendation systems are about personalization. It's about taking your product that works for everyone and personalizing it for an individual user

In a content-based recommendation system, you use the metadata about your products.

In collaborative filtering, you don't have any metadata about the products, instead you learn about item similarity and user similarity from the ratings data itself

## Types of Recommendation System
### Content-based
A Content-based method uses attributes of the items to recommend new items to a user. It doesn't take into account the behavior or ratings of other users. For example, if a user has rented and liked a lot of vacation homes on the beach, this method will suggest other similar homes that are also on the beach. This is often done by hand engineering features for the items and learning how much a single user aligns with each of those features. Using that feature representation of the user is impossible to extrapolate how a given user would rank unseen items.

### collaborative filtering
A collaborative filtering model works with the entire user item interaction matrix. They consider all users, all items, and all user item ratings. Loosely speaking, they work with the idea that similar users will like similar items. That is, they use similarities between the users and the items simultaneously to provide recommendations. This can allow for seemingly serendipitous recommendations. Meaning, they can recommend an item to a user A based only on the interests of a similar user B. Another useful advantage is that the feature representations can be learned automatically. So, you don't have to rely on hand engineering specific features as you would for a content-based filtering method. This process often involves matrix factorization and behaves similarly to a Content-basec approach, but does not rely on previously constructed features.

### Knowledge-based
Knowledge-based recommender systems are based on explicit knowledge about the user's preferences, items, and or recommendation criteria. They're especially useful when alternative approaches such as collaborative filtering or content-based methods cannot be applied. This occurs in situations where items are not purchased very often.

### Hybrid
If a user has already rated a large number of items, perhaps we can rely on a content-based method. However, if the user has rated only a few items, we may instead prefer to use a collaborative filtering approach.
Of course, if we have no information about a user's previous item interactions or we like any information about a given user, we may instead want to rely on a knowledge-based approach, and ask the user directly for their preferences via a survey before making recommendations.
Another way to create a hybrid model is to simply combine the outcomes of more than one of these models.

deep learning models can also be used when building a recommendation system. Deep neural networks work well because they are flexible and can be trained to have varying outcomes, such as predicting ratings, interactions, or even next items.
![](dnn)

## Recommendation System Pitfalls
### Sparse
- Most item were rated by very few users.
- Most users rate only small fraction of items.
### Skew
- Some properties are very popular.
- Some users are very prolific.

### Cold start problem
This happens when there aren't enough interactions or information for users or items

Because collaborative filtering relies on user item interactions, without this information, reliable recommendations for users aren't generated. In this situation, a content-based approach would be better

### lack of explicit user feedback
Often we don't have explicit measures to feed to a recommender system. In situations like this, it is necessary to rely on implicit ratings. For example, consider a YouTube video like this one. Of the tens of thousands of views, there're substantially fewer upvotes or downvotes. Instead, implicit measures must be used. Things like the portion of the video watched, or the number of clicks, play counts, or other information about the user interaction like site navigation, or time spent on the page. In practical scenarios, implicit feedback like this is much more readily available, even though explicit user feedback is ground truth and preferred

![]()
With enough data, you can train an initial model that uses implicit user feedback to learn an explicit rating

## Building a Simple Vector-Based Model
### Content-Based Recommendation Systems
Content-based filtering methods use item features to recommend new items that are similar to the user has already liked, based on their previous actions or explicit feedback. They don't rely on information about other users or other user item interactions.
### Similarity measure
A similarity measure is just a metric that defines exactly how similar are close to items are in the **embedding space**. One commonly used similarity measure is the dot product.
### Building a User Vector
![](user feat vec1, 2)
### Making Recommendations Using a User Vector
![](user item rating)

it's hard to extent the user's interests using content-based recommendation sys. 
## Building a Content-Based Recommendation System with a Neural Network
### Using Neural Networks for Content-Based Recommendation Systems
![](nn feature2result)
Use NN to directly predict the next item recommend to user by training on features of already bought items.

## COLLABORATIVE FILTERING RECOMMENDATION SYSTEMS
### Embedding Users and Items
Assume there're U users, V items.
The user-item interaction matrix will be in size U\*V.
Instead of explictly recording the matrix, we can represent a user or a item using a k-dim vector and present the interaction as dot product of a user and an item.
As long as the k < U\*V/2*(U+V), we are saving spaces than original matrix.
### Factorization Approaches
Now we can define loss as  sum(sqr(A_ij - k_ui * k_vi)).

Let's look at the solvers' pros and cons
**SGD**
pros
    - flexible
    - parallel
cons
    - slower
    - hard to handle unobserved interaction pairs

**ALS (Alternating Least Squares)** 
pros
    - parallel
    - Faster convergence
    - can handle unobserved interaction pairs
cons
    - Least squars only

**WALS (Weighted ALS)**
set to 0 and give some weight on unobserved user-interaction matrix pairs. 

There are many ways to handle unobserved user-interaction matrix pairs. **SVD** explicitly sets all missing values to zero. **ALS** simply ignores missing values. **WALS (Weighted ALS)** uses weights instead of zeros that can be thought of as representing **low confidence**.

### Cold Starts
Collaborate filtering has
pros
    - no domain knowledge
    - serendipity (interest can be introduced by other user, instead only yourself)
    - great staring point
cons
    - fresh items/users
    - context features (we can't embed our domain knowledge)

![](hybrid content-collab)
base on the condition, choose how we recommend
1. very new user: content based
2. new user: recommend by similar user
3. user: recommend by his own preference

If we want a recommendation system that uses collaborative filtering, what are some strategies to get around the cold start problem of fresh users/items? **(e)**
(a)Use averages from the other users/items
(b)Convert to hybrid model, add item info (content-based) 
(c)Convert to hybrid model, add user info (knowledge-based)
(d)Use other user-item interaction data
(e)All of the above

## Hybrid Recommendation Systems
![](hybrid pro cons)
