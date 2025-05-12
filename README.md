## Reconhecimento de dígitos manuscritos (HDR) usando rede neural convolucional (CNN) em SystemVerilog

O Reconhecimento de Dígitos Manuscritos é o processo de digitalização de imagens de dígitos manuscritos por humanos. É uma tarefa
difícil para a máquina, pois os dígitos manuscritos não são perfeitos e podem ser produzidos com uma variedade de variações. Neste projeto, desenvolvemos
um modelo de Rede Neural Convolucional (CNN) utilizando o SystemVerilog para o Reconhecimento de Dígitos Manuscritos. Uma rede neural convolucional
(CNN ou ConvNet) é um algoritmo de Aprendizado Profundo que pode receber uma imagem de entrada, atribuir pesos e vieses aprendíveis
a vários objetos na imagem e ser capaz de distingui-los.

## Layers da Rede Convolucional 
<p align="center">
<img title="Rede Convolucional Diagrama" alt="Alt text" src="images/diagrama_rede_convolucional.png">
</p>

## Diagrama de blocos do SystemVerilog da Rede Convolucional 
<p align="center">
<img title="Rede Convolucional Diagrama de Blocos" alt="Alt text" src="images/diagrama_de_blocos.png">
</p>

## Entrada
<p align="center">
<img title="Entrada da Rede" alt="Alt text" src="images/input.png" width="20%" height="20%">
</p>

## layer 1 - CONVOLUÇÃO 1
<p align="center">
<img title="Mapa de Característico 0" alt="Alt text" src="images/conv1_layer0.png" width="20%" height="20%">
<img title="Mapa de Característic0 1" alt="Alt text" src="images/conv1_layer1.png" width="20%" height="20%">
</p>

## layer 2 - MAXPOOLING 1
<p align="center">
<img title="Mapa de Característico 0 - Maxpooling" alt="Alt text" src="images/maxpooling0_layer2.png" width="20%" height="20%">
<img title="Mapa de Característic0 1 - Maxpooling" alt="Alt text" src="images/maxpooling1_layer2.png" width="20%" height="20%">
</p>

## layer 3 - CONVOLUÇÃO 2
<p align="center">
<img title="Mapa de Característico 0" alt="Alt text" src="images/conv0_layer3.png" width="20%" height="20%">
<img title="Mapa de Característic0 1" alt="Alt text" src="images/conv1_layer3.png" width="20%" height="20%">
<img title="Mapa de Característic0 2" alt="Alt text" src="images/conv2_layer3.png" width="20%" height="20%">
<img title="Mapa de Característic0 3" alt="Alt text" src="images/conv3_layer3.png" width="20%" height="20%">
</p>

## layer 4 - MAXPOOLING 2
<p align="center">
<img title="Mapa de Característico 0 - Maxpooling" alt="Alt text" src="images/maxpooling0_layer4.png" width="20%" height="20%">
<img title="Mapa de Característic0 1 - Maxpooling" alt="Alt text" src="images/maxpooling1_layer4.png" width="20%" height="20%">
<img title="Mapa de Característic0 2 - Maxpooling" alt="Alt text" src="images/maxpooling2_layer4.png" width="20%" height="20%">
<img title="Mapa de Característic0 3 - Maxpooling" alt="Alt text" src="images/maxpooling3_layer4.png" width="20%" height="20%">
</p>

## layer 5 - FLATTEN
<p align="center">
<img title="ACHATAMENTO" alt="Alt text" src="images/flatten_layer5.png" width="100%" height="100%">
</p>


## layer 6 - DENSE
<p align="center">
<img title="DENSE" alt="Alt text" src="images/dense_layer6.png"  width="100%" height="100%">
</p>

## Exemplo de convolução matricial
<p align="center">
<img title="Exemplo de convolução matricial" alt="Alt text" src="images/conv.png">
</p>

Links úteis:
[Convolutional Neural Network | Deep Learning](https://developersbreach.com/convolution-neural-network-deep-learning/).

[CNN EXPAINER](https://poloclub.github.io/cnn-explainer/#article-convolution).

[Deep CNN-DESIGN](https://www.baeldung.com/cs/deep-cnn-design)


[Single-Layer CNN using Verilog](https://santoshsrivatsan24.github.io/ece564_project1.html)


[Verilog Neural Network](https://yycho0108.github.io/CompArchNeuralNet/)


[2D Convolution in Hardware](https://sistenix.com/sobel.html)


[Verilog Project Ideias](https://vlsiverify.com/verilog/verilog-project-ideas/)

[The Convolutional Filter](https://medium.com/advanced-deep-learning/cnn-operation-with-2-kernels-resulting-in-2-feature-mapsunderstanding-the-convolutional-filter-c4aad26cf32)



<p align="center" width="100%">
    <img width="32%" src="images/preprocessamento.jpg">
    <img width="32%" src="images/posprocessamento.jpg">
    <img width="32%" src="images/maxpoolingposprocessamento.jpg">
</p>