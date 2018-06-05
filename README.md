
# Striker

[![Build Status](https://travis-ci.org/dwyl/esta.svg?branch=master)](https://travis-ci.org/dwyl/esta)

## Propósito

Aplicar una técnica de interacción(ver Referencias: 1) en un ambiente 3D, que requiere de los gestos realizados por dos dedos en una pantalla multitouch, logrando una manipulación con seis grados de libertad (6-DOF) sobre un objeto. Dicho objeto tridimensional (en este caso, un cubo con textura de dado) se encuentra inmerso en un ambiente que responde a los gestos realizados.

En consecuencia, se construyó una aplicación haciendo uso del modo Android de [Processing](http://android.processing.org/) (el *target* es API 25), el cual ofrecía [casi todas](http://android.processing.org/reference/index.html) las funcionalidades tanto del API de Processing como el de Android, permitiendo obtener la información de la pantalla multitouch y procesarla. El ambiente sobre el cual se dibujó la escena, el objeto y sus métodos de interaccion fue gracias a la versión 0.1.2 de  la librería [frames](https://github.com/VisualComputing/framesjs/releases/tag/v-0.1.2). Es de mencionar también, que gracias al tutorial de gestos (ver Referencias: 4) se logró una mejor comprensión del manejo de los eventos a muy bajo nivel que provee la API de Android.

## Integrantes

| Integrante | github nick |
|------------|-------------|
|Luis Ernesto Gil Castellanos|luegilca|


## Referencias

1. Jingbo Liu, Oscar Kin-Chung Au, Hongbo Fu, Chiew-Lan Tai. *Two-Finger Gestures for 6DOF Manipulation of 3D Objects* (2012) [link](https://pdfs.semanticscholar.org/d02b/a5210b5d2bd6e0a480514c81f3d3356d24c3.pdf)
2. Jacek Jankowski, Martin Hachet. *Survey of Interaction Techniques for Interactive 3D Environments* (2013) [link](https://hal.inria.fr/hal-00789413/document)
3. Jason L. Reisman, Philip L. Davidson, Jefferson Y. Han. *A Screen-Space Formulation for 2D and 3D Direct Manipulation* (2009)
4. Fredrik Bornander. *Simple Gestures on Android* (2012) [link](https://www.codeproject.com/Articles/319401/Simple-Gestures-on-Android)

