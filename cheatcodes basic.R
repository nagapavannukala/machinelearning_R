a = c(1,2,2,4)
b = c("a","b")
newvec = c(a,b)
newvec
newvec = c(a,b,TRUE)
newvec


emptyvec = c() # creating empty vector
emptyvec
emptyvec[2] = 2
emptyvec
# indexing
a[5]= 5
a

a[10]= 5
a# it gives NA values in the middle.

a=append(a,6) #it joins the element at the last position of the vector.
a

a = 1:100
a[34:40] # accessing a range of elements or a number
b=c(20,28,34) # creating a new vector of locations and using this to access the elements
a[b]
a[c(28,20,34)]

mystr = c("b","bc","acdf",101)
length(mystr) # it gives the number of elements in the vector 

nchar(mystr) # number of characters in each element
mystr


myvec  = c("Hello",12.23)
nchar(myvec) # here '.' is also considerred as an character in an element.

mystr = c("b","bc","acdf") 
mystr=="a" ## check if the element-a is located in the vector. '=='is called as logical operator.'=' is called as assigning operator.

a
b
# to check the class of the element or a vector or a dataframe.
is.logical(a)
is.numeric(a)
is.numeric(b)
is.character(a)
is.integer(b)
# using the sequence function.
a = seq(1,10,2)
a

a = seq(20,1,-0.5)
a
a = seq (10, by = 2, 20)
a
a = seq (10,20, by = 2)
a
rep(5,10)
rep(1:4, 10)
rep(1:4, each=3) # each element is taken 3 times continuously and moving on to next variable.
rep(1:4, each=3)

rep(1:4, each = 3, times = 2 ) # the whole sequence is repeated 2 times.

#How to generate 10 random numbers ?
  runif(10)

a=runif(10)
a
a = runif(10,min=50,max=60)
a # this gives random numbers b/w 50 and 60 but it wold be float type.
# if I want it to be converted into integer(typecast to an integer)
a = as.integer(a)
a

#What is the names() function do to a vector ?
#  A)It would assign names to the elements of vector

#Suppose my vector (a) has 3 elements (1,2,3)

#names(a)=c("small","medium","large")


num = c(1:3)

labels = c("one", "two" , "three")
names(num)= labels
num

a=1:10
a[5]=NA
a
a = na.omit(a)
a
a


a=c(1:10)

b=a[-c(5)]
b
#Vector b would contain all the elements from vector (a) except the 
#5th element from vector (a) , it does not replace it with NA but just remove it from the vector.
a



a = 1:10
a[a>5] # gives the elements that are greater tahn 5
which(a>5)

b= c(1,11,6,1,3,34)
which(b>3) # gives the index positions whose value >3

which.min(a)    #This will print the position of the minimum element in the vector "a"

which.max(a)   #which always gives the info about index position.

which.min(b)

which.max(b)


order(b) # gives the index position of the sorted values.

b[ -(max(b)) ]
?which.names
max(b[b!=max(b)]) # finding the second largest number 
b
rank(b)
length(b)
b[rank(b)==(length(b)-0)]
b[rank(b)==(length(b)-1)]# 2nd largest number
b[rank(b)==(length(b)-2)]# 3rd largest number
# here rank assigns the smallest number the small rank(like after sorting in ascending order, 
# the samllest is given rank as 1 )
# when rank = length i.e., the maximum we can get the maximum number.
# 2nd largest number
b[as.integer(rank(b))==(length(b)-5)] #the special case where there are repeated numbers.
# the rank is converted into decimal places.

## LISTS
v1 =c("true","false");
v2= 1:5
v3 = c("cat","dog")
my_list=list(v1,v2,v3)
my_list[1] 

my_list[[3]][2] # for accessing "dog", we cna go to 3rd level and 2nd element

my_list[[3]][2] = NA

my_list[[3]][2]
# but 
my_list[[3]][2] = NULL ## this doesn't work.

newlist = list(1,2,"Hello",TRUE)
newlist[1]
## assigning names to the list elements(i.e., vectors)
v1 =c("true","false");
v2= 1:5
v3 = c("cat","dog")
my_list=list(v1,v2,v3)
mynames = c("A","B","C")

names(my_list) = mynames
my_list


# for referencing
my_list$A
my_list["A"]



l1 <- list(10,20,30,40)
l2 <- list("Sun","Mon","Tue","Wed")

merg_list <- c(l1,l2)

print(merg_list)


a=1:10
is.element(1,a) # it means that is 1 an element in 'a'

a=c(1:6)
b=c(5:10)
a
b
is.element(a,b) # is every element of vector 'a' present in vector 'b'


sample(a)
set.seed(100)

#set.seed(100) can be any number , instead of 100, we can use any number ! However if we want the ordering to be same, we have to use the same seed value

#i.e

sample(a)
set.seed(50)
sample(a)

#The above 2 sampling will produce same sample ordering

# if we aren't setting the seed the system takes the seed automatically.
# better you set the seed and control it

sample(a,5)
sample(a,20) # now it won't work , for that to work we need to give'replace = T'
sample(a,20,replace = T)



b=1:9
c = sort(b, decreasing=TRUE)
c
c = sort(b)
c
c=rev(sort(b))
c
?rev

x = c(11,34,-1,4,21)
sort(x)


b=c(-1,100,2)
b
order(b) ## it gives the index positions of the sorted values.


## lubridate package is used to work with date and time 






#=================DATE and TIME types in R===========================
#  q)To know the current date, the command would be 
#Sys.Date()

#q)To get the current date and time, the command would be 
#date()

#A sample examples with date types 

#d1 = "2016-06-27"
#d2 = "2017-05-21"

#d2-d1 would give the number of days between the 2 dates 

#Refer to the below link for more info on Date type in R 
# http://www.statmethods.net/input/dates.html

#Refer to the below link for time operations in R 
#http://www.cyclismo.org/tutorial/R/time.html

#=====================================================================
  
  
  
 # ===========IF-ELSE operations in R and logical operators=============
  a = 2 
b = 5 
if(a>b) { 
  print("a>b") 
} else 
{ 
  print("a is not greater than b") 
}

# Note: The else statement must start in the same line where the closing bracket for the if statement ends. 

# q)A sample program demonstrating logical OR  

#Problem statement: To check if a number is prime or not
# Logic : Lets take a number 5, the nearest perfect square number which is less than 4 is 5, so we need to check if 5 is divible by all integers from 2 to 4, if divibile then 5 is not a prime number 

a=5
if(a %% 2 == 0 | a %% 3 ==0 | a %% 4 ==0) ## %% -> it means "remainder".
{
  print("a is not a prime number") 
} else 
{
  print("a is a prime number")
}

## '||' means or operator. '|' also means or operator.

# q)A sample program to demonstrate the logical OR,AND operator along with else-if statement

age = 37
education = "PG"
status = "married"
if(age < 35 && education == "PG" && status == "married")
{
  print("The candidate is eligible for AUS immigration")
 } else if(status == "single") 
{
  print("The candidate is rejected since the status is single") 
}else if(education !="PG") 
{
  print("The candidate is rejected since education is not PG")
}else if(age > 35)
{
  print("The candidate is rejected since age is over 35")
}

#Note: != (! is a NOT operator, != stands for not equal to)




#---nested if-else statements-----
age = 27
education = "PG"
status = "single" 

if(age < 35) { #first level of nexting
  if(education=="PG") { # 2nd level
    if(status == "married") { # 3rd level
      print("Eligible for immigration")     
    }else {  
      print("Not eligible for immigration because you are married")     } # end of 3rd level
  } else {  
    print("Not eligible for immigration due to education")     }# end of second level 
}else {  
  print("Not eligible for immigration due to age")     } # end of first level 


#Note: One should be very careful with closing brackets while using 
#nested if-else statements, and avoid more than 2 levels of nesting 
#and try to use else-if instead of nested if-else conditions
# One more point to be noted is that you should be careful to include 'else' in every case of 'if'.  

##============================= FOR LOOPS =============================
  
 ## A simple looping condition to print the first 5 even numbers

for(i in c(1:40)) {
  if(i%%2==0) {
    print(i)}
}
 # Another way of achieving the same would be .
  
  a = 1:10
  for(i in a)
  {
    if(i%%2==0) {print(i)} 
  }      
  
  WAP0 : To print the first 30 odd numbers 
  
  
  ----repeat loop and the break statement-----
    i=0
  repeat {
    print(i)
    if(i==10) {break}  # Break statement is used to exit the loop 
    i=i+1
  }
  
  WAP1 : Modify the above code to make it into an infinite loop 
  
  WAP2 : Modify the above code to print the first 20 numbers divisible by 5
  Justify : How is the repeat statement better than the for loop for the previous question 
  
  i=0
  repeat{
    i = i+1
    if(i%%5 == 0 ){print(i)}
    else if
    (i>100) {break}
         }
  
  ----------------------------WHILE LOOPS------------------------------
    i=0;
  
  while(i<10)
  {
    print(i)
    i=i+1
  }
  
  q)In the above program, change the print(i) to cat(i) and observe the difference
  q)Now change the cat(i) with cat(i," ") and observe the difference
q) Try the below with cat and print and you will be able to appriciate the usefullness of cat when compared to print 

a=10
print("a=",a)
cat("a=",a)

q)How to print a new line 
cat("\n") 



Note: While loops are a better choice than repeat (try to justify the reason)


WAP3:Write a program to print the first 10 fibonacci numbers 
0,1,1,2,3,5 .. is the fibonacci series which is formed by adding the 
number to the previous number 






------------------------------Nested loops-------------------------------
  q) I would like to print the following pattern 

1 2 3 4 5 
1 2 3 4 5 
1 2 3 4 5 

q)How to approach this problem ?
  First count the number of rows , its 3 
Find the max element we are printing in each row, its 5
What is the first element we are printing , its 1, so we initialize i=1
rows = 3
max = 5 
i=1  
a = 1 # This is an initializer to the outer loop  
while(a<=rows)    # This loop will execute 3 times    
{
  while(i < 5 )  {  # This loop will print 1 2 3 4 5
    cat(i," ") 
    i=i+1
  }
  cat("\n") # This will print a new line each time 1 2 3 4 5 is printed   
  i=1  # We need to re-initialize i=1 so that the next line is 1 2 3 4 5 
  a=a+1
}


WAP4 : Modify the above program to print 
5 4 3 2 1
5 4 3 2 1
5 4 3 2 1
5 4 3 2 1
5 4 3 2 1


WAP5: A program to print the below pattern 
9 8 7  
6 5 4  
3 2 1


By now the you would have a pretty good hold on loops ! 
  -------------------------------------------------------------------------
  
  ====================User defined functions======================
  
  A sample program which demonstrates the use of funtions 
#myfunc is the function name and , "a" is the argument it takes


myfunc = function(a) { # A function to print hello 5 times 
  i = 1 
  while( i <= a) {
    print("Hello")
    i=i+1
  }
  
} # end of function	

myfunc(5) # Calling a function, 5 is the value that gets passed to "a"


# ==============================================================================

mysum = function(a,b)
{
  sum(a,b)
}
result = mysum(10,20)
print(result)

#=====================================================================================

WAP 11: Write a function to print the squares of the first N natural numbers, where N would be the argument the user passes to the function 

myfunc = function(N) { # A function to print hello 5 times 
  i = 1 
  while( i <= N) {
    print(i*i)
    i=i+1
  }
  
} # end of function	

myfunc(5)



------------Functions without arguments-----------------
  greetings = function() {
    print("Hello..good morning")
  }

greetings() # Calling the function 


----------Functions with default arguments-----------------
  myfunc = function(a=6,b=4)
  {
    s=a+b
    print(s)
  }

myfunc()


-------------------Functions returning values----------------
  mysum = function(a,b)
  {
    s = a+b
    return(s)
  }

print(mysum(10,20))


-----------------Functions returning values in a different way---------
  mysum = function(a,b)
  {
    s = a+b  # "s" will be automatically returned
  }

print(mysum(10,20))



-----------------Functions returning values in a different way---------
  mysum = function(a,b)
  {
    s = a+b  # "s" will be automatically returned
  }

print(mysum(10,20))


q)Try this ..
mysum = function(a,b)
{
  s = a+b  
  b = 100 #Since b is the last object in this block, b will be returned 
} 


print(mysum(10,20))

Note: Function can return only one object at a time, in case you need to return more than one object, we might have to use vectors or lists


WAP12: Write a program where a vector with 10 numbers is passed on 
to a user defined function, increment every number in the vector 
and return it back to display the contents.  

------Passing variable number of arguments to a function------- 

  neo <-function(...) {
    {
      myl = list(...)
      print(myl)
      Sum = myl[[2]][1] + myl[[3]][1]
      print(Sum)
    }
  }


    neo("Hello",1,21.34,3)
    
## '...' is used to pass variable number of arguments   
   
    
    #============================================
    
    horlicks = function(...){
      mylist = list(...)
      print(mylist)
      sum = 300
    }
    
    val = horlicks("hello",12.34)
    
    
    
    #===============================================
    
    
    neo <-function(...) {
      {
        myl = list(...)
        print(myl)
        
      }
    }
    
    Sum = 0
    for(i = 1: length(myl){
      while(class(myl[i]) = numeric){
        sum = Sum + myl[i]
        i = i+1
        print(sum)
      }}
    neo("Hello",1,21.34,3)
#==================================================
    ## If we put return() in the middle of 100 lines code, the code gets executed upto that only
    # and it shows that output, it doesn't execute after that.
    
    myudf = function(a)
    {
      if(a == "Ram")return(a)
      else if (a == "Bob") {print("jai Bob")}
      else if (a == "Sham"){print("jai Sham")}
    }
    myudf("Ram")
    
    #==================================================
    
    for (i in c("cat","dog",1,2,3)){
      print("hello")
    }
    # 'for' loop defining is based on count of observations in the i array
    #===========================
    
    for (i in c("cat","dog",1,2,3)){
      print(i)
    }
    
    #===========================================
    ## for printing 1st 30 odd numbers.
    a = 1:100
    for(i in a)
    {
      if(i%%2 != 0 && i < 60 ){print(i)}
    }
    #=============================================
    
    ----------------------------WHILE LOOPS------------------------------
      i=0;
    
    while(i<10)
    {
      print(i)
      i=i+1
    
    print("hello")
    }
    
    
    ## print 1st 30 odd numbers without mentioning i<60
    
    counter = 0
    i=1
    while(counter < 30)
    {
      if(i%%2 != 0 ){
        print(i)
        counter = counter + 1
      }
      i = i+1
    }
    
 ## sum of squares of 1st 100 even numbers   
    counter = 0
    sum = 0
    i=1
    while(counter < 100)
    {
      if(i%%2 == 0 ){
        sum = sum + i^2
        
        counter = counter + 1
      }
      i = i+1
    
    }
    print(sum)
    
    
    ## user defined function for number of even numbers
    SS  = function(a)
    {
      counter = 0
      sum = 0
      i=1
      while(counter < a)
      {
        if(i%%2 == 0 ){
          sum = sum + i^2
          
          counter = counter + 1
        }
        i = i+1
        
      }
      print(sum)
    }
   
    
     SS(100)
    
    
  ##  Extend the above program to a user defined function where 
     #the n value is defined while calling the function
    
    
     SS  = function(a)
     {
       counter = 0
       sum = 0
       i=1
       while(counter < a)
       {
         if(i%%2 == 0 ){
           sum = sum + i^2
           
           counter = counter + 1
         }
         i = i+1
       }
       print(sum)
     }
     SS(100)
     
     
## WAP  to find the sum of squars of odd numbers within a range which would be specified by the user.
## i.e., I want the sum of squares  of all odd numbers between 100 and 200.
     #This must be re-usable using a function.

     SS  = function(Min,Max)
     {
       
       sum = 0
       i= Min
       while(i < Max )
       {
         if(i%%2 == 0 ){
           sum = sum + i^2
           
         }
         i = i+1
       }
       print(sum)
     }
     SS(100,200)
    
     
     #### 
     
     SS  = function(N)
     {
       
       sumo = 0
       sume = 0
       i= 0
       while(i <= 2*N  )
       {
         if(i%%2 == 0 ){
           sume = sume + i^2
         }else if (i%%2 != 0){
           sumo = sumo + i^2
         }
         i = i+1
       }
       print(sume)
       print(sumo)
     }
     SS(2)
    
     #########
     
     SS  = function(N,cond)
     {
       sum = 0
       
       i= 0
       while(i <= 2*N  )
       {
         if(cond == "even" ){
           if(i%%2 == 0){
           sum = sum + i^2
           }
         }else if (cond == "odd"){
           if (i%%2 != 0){
             sum = sum + i^2
                          }
                                 }
         i = i+1  }
       print(sum)
       }
       
     
     SS(2,"even")  ## even
     SS(2,"odd")  ## odd 
    
    