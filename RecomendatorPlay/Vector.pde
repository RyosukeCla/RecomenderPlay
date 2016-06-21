
/*

======================================
=========       VECTOR       =========
======================================
  @author ..... Ryosuke Suzuki
  @created .... 05/30/2016
  @updated .... 06/19/2016

USAGE:

Vector (10.0, 10.0, 10.0) = 3 dimention Vector (10.0, 10.0, 10.0)
Vector (1.0, 1.0, 1.0, 1.0, 1.0) = 5D Vector (1.0, 1.0, 1.0, 1.0, 1.0)
Vector (float[]) is Ok
Vector (Vector) = deep copy
Vector (int N) = N Dimention zero vector

.toRandomUnit () = vector turn to random unit vector (e) (n > 1)
.toRandomUnit2D ()
.toRandomUnit3D ()
.toZero () = zero vector
.getAt (int index) : eg. (2.0, 20.0, 10.0).getAt(2) = 10.0;
.getArray () : 
.set (float...) :
.set (float[]) is ok
.set (Vector) is ok
.setAt (int index, float value) : eg (2.0, 20.0, 10.0).setAt(2, 3.0) => (2.0, 20.0, 3.0)
.add (Vector)
.sub (Vector)
.mult (float)
.div (float)
.dot (Vector) : A*B. dot. not cross.
.normalize () : to unit vector
.sqrMagnitude () : get |A|^2
.magnitude () : get |A|
.distance (Vector) : euclidian distance
.size () : elements size
.toString () : (1.0, 2.0, 3.0).toString() => "(1.0, 2.0, 3.0)"



*/

import java.io.*;
import java.security.*;

class Vector {
  private float[] elements;
  
  public Vector (float... element) {
    this.elements = new float[element.length];
    for (int i = 0; i < element.length; i++) {
      if (Float.isNaN (element[i])) {
        throw new InvalidParameterException ("null is invalid.");
      }
      this.elements[i] = element[i];
    }
  }
  
  public Vector (Vector vector) {
    this.elements = new float[vector.elements.length];
    for (int i = 0; i < vector.elements.length; i++) {
      this.elements[i] = vector.elements[i];
    }
  }
  
  public Vector (int dimention) {
    if (dimention <= 0) {
      throw new InvalidParameterException ("negative or zero is invalid.");
    }
    this.elements = new float[dimention];
    for (int i = 0; i < dimention; i++) {
      this.elements[i] = 0.0;
    }
  }
  
  public float getAt (int index) {
    if (index < 0 || index >= this.elements.length) {
      throw new InvalidParameterException ("index is invalid");
    }

    return this.elements[index];
  }
  
  public float[] getArray () {
    return this.elements;
  }
  
  public void set (float... element) {
    if (element.length != this.elements.length) {
      throw new InvalidParameterException ("not match");
    }
    for (int i = 0; i < elements.length; i++) {
      if (Float.isNaN(element[i])) {
        throw new InvalidParameterException ("null is invalid");
      }
      this.elements[i] = element[i];
    }
  }
  
  public void set (Vector vector) {
    check (vector);
    for (int i = 0; i < elements.length; i++) {
      this.elements[i] = vector.elements[i];
    }
  }
  
  public void setAt (int index, float value) {
    if (index < 0 || index >= this.elements.length) {
      throw new InvalidParameterException ("index is invalid");
    }
    if (Float.isNaN (value)) {
      throw new InvalidParameterException ("null is invalid");
    }
    this.elements[index] = value;
  }
  
  public void add (Vector vector) {
    check (vector);
    for (int i = 0; i < this.elements.length; i++) {
      this.elements[i] += vector.elements[i];
    }
  }
  
  public void sub (Vector vector) {
    check (vector);
    for (int i = 0; i < this.elements.length; i++) {
      this.elements[i] -= vector.elements[i];
    }
  }
  
  public void mult (float c) {
    if (Float.isNaN(c)) {
      throw new InvalidParameterException ("null is invalid.");
    }
    for (int i = 0; i < this.elements.length; i++) {
      this.elements[i] *= c;
    }
  }
  
  public void div (float c) {
    if (Float.isNaN(c) || c == 0.0) {
      throw new InvalidParameterException ("cannot devide by null or 0.");
    }
    float dv = 1 / c;
    for (int i = 0; i < this.elements.length; i++) {
      this.elements[i] *= dv;
    }
  }
  
  public void normalize () {
    this.div (this.magnitude());
  }
  
  public void toRandomUnit2D () {
    if (this.elements.length != 2) {
      throw new InvalidParameterException ("this vector is not 2d.");
    }
    float theta = PI * random (0.0, 360.0) / 180.0;
    this.elements[0] = sin (theta);
    this.elements[1] = cos (theta);
  }
  
  public void toRandomUnit3D () {
    if (this.elements.length != 3) {
      throw new InvalidParameterException ("this vector is not 3d.");
    }
    float theta = random (0.0, 2.0) * PI;
    float phi = random (0.0, 1.0) * PI;
    this.elements[0] = sin (theta) * cos (phi);
    this.elements[1] = sin (theta) * sin (phi);
    this.elements[2] = cos (theta);
  }
  
  public void toRandomUnit () {
    if (this.elements.length == 1) {
      this.elements[0] = random (-1.0, 1.0);
      this.normalize ();
      return;
    }
    float[] theta = new float[this.elements.length - 1];
    theta[theta.length-1] = random (0.0, 2.0) * PI;
    int i, j;
    for (i = 0; i < theta.length-1; i++) {
      theta[i] = random (0.0, 1.0) * PI;
    }
    
    for (i = 0; i < this.elements.length - 1; i++) {
      this.elements[i] = 1.0;
      for (j = 0; j < i; j++) {
        this.elements[i] *= sin (theta[j]);
      }
      this.elements[i] *= cos (theta[i]);
    }
    
    this.elements[this.elements.length - 1] = 1.0;
    for (i = 0; i < theta.length; i++) {
      this.elements[this.elements.length - 1] *= sin (theta[i]);
    }
    this.normalize ();
  }
  
  public void toRandom () {
    for (int i = 0; i < this.elements.length; i++) {
      this.elements[i] = random (0.0, 1.0);
    }
  }
  
  public void toZero () {
    for (int i = 0; i < this.elements.length; i++) {
      this.elements[i] = 0.0;
    }
  }  
  public float sqrMagnitude () {
    float result = 0.0;
    for (int i = 0; i < this.elements.length; i++) {
      result += this.elements[i] * this.elements[i];
    }
    return result;
  }
  
  public float magnitude () {
    float result = 0.0;
    for (int i = 0; i < this.elements.length; i++) {
      result += this.elements[i] * this.elements[i];
    }
    result = sqrt(result);
    return result;
  }
  
  public float distance (Vector vec) {
    float result;
    Vector dist = new Vector (this);
    dist.sub (vec);
    result = dist.magnitude ();
    return result;
  }
  
  public float dot (Vector vector) { 
    check (vector);
    float result = 0.0;
    for (int i = 0; i < this.elements.length; i++) {
      result += this.elements[i] * vector.elements[i];
    }
    return result;
  }
  
  public String toString () {
    String result = "";
    result += "(";
    for (int i = 0; i < this.elements.length - 1; i++) {
      result += this.elements[i];
      result += ", ";
    }
    result += this.elements[this.elements.length - 1];
    result += ")";
    return result;
  }
  
  public int size () {
    return this.elements.length;
  }
  
  private void check (Vector vector) {
    if (vector == null) {
      throw new InvalidParameterException ("null is invalid");
    }
    if (this.elements.length != vector.elements.length) {
      throw new InvalidParameterException ("not match elements");
    }
  }
}