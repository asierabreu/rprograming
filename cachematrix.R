## Put comments here that give an overall description of what your
## functions do

#
# Function that creates a recursive object (list) containing a methods for the given input matrix
# This methods are:
# 1. set the matrix
# 2. get the matrix
# 3. set the inverse of matrix
# 4  get the inverse of matrix
makeCacheMatrix <- function(x = matrix()) {
    inv_x <-NULL
    set <- function(y) {
      x <<-y
      inv_x <<-NULL
    }
    get <- function() x
    setinverse <-function(inversevalue) inv_x <<-inversevalue
    getinverse <-function() inv_x
    list(set=set,get=get,
         setinverse=setinverse,
         getinverse=getinverse
         )
}

#
# Function to return the inverse of a matrix
# Uses the solve function for matrix
#
cacheSolve <- function(x) {
       mcm<-makeCacheMatrix(x)    
       inv_x <-mcm$getinverse()
       if(!is.null(inv_x)) {
          message("returning cached inverse for matrix")
          return(inv_x)
       }
       mat <- mcm$get()
       inv_x<-solve(mat)
       mcm$setinverse(inv_x) 
       mcm
       inv_x
}
