## Reconhecimento  dígitos manuscritos (HDR) usando re neural convolucional (CNN) em SystemVerilog

O Reconhecimento  Dígitos Manuscritos é o processo  digitalização  imagens  dígitos manuscritos por humanos. É uma tarefa
difícil para a máquina, pois os dígitos manuscritos não são perfeitos e podem ser produzidos com uma grande variabilidade. Neste projeto, desenvolvemos
um modelo de Rede Neural Convolucional (CNN) utilizando o SystemVerilog para o Reconhecimento  Dígitos Manuscritos. Uma rede neural convolucional
(CNN ou ConvNet) é um algoritmo  Aprendizado Profundo que pode receber uma imagem de entrada, atribuir pesos e vieses aprendíveis
a vários objetos na imagem e ser capaz  distingui-los.

## Layers da Rede Convolucional 
<p align="center">
<img title="Rede Convolucional Diagrama" alt="Alt text" src="images/diagrama_rede_convolucional.png">
</p>

## Diagrama de blocos do SystemVerilog da Rede Convolucional 
<p align="center">
<img title="Rede Convolucional Diagrama  Blocos" alt="Alt text" src="images/diagrama_de_blocos.png">
</p>

## Entrada
<p align="center">
<img title="Entrada da Rede" alt="Alt text" src="images/input.png" width="50%" height="50%">
</p>

## layer 1 - CONVOLUÇÃO 1
<p align="center">
<img title="Mapa Característico 0" alt="Alt text" src="images/conv1_layer0.png" width="25%" height="25%">
<img title="Mapa Característico 0" alt="Alt text" src="images/conv1_layer1.png" width="25%" height="25%">
</p>

## layer 2 - MAXPOOLING 1
<p align="center">
<img title="Mapa Característico 0 - Maxpooling" alt="Alt text" src="images/maxpooling0_layer2.png" width="25%" height="25%">
<img title="Mapa Característico 0 - Maxpooling" alt="Alt text" src="images/maxpooling1_layer2.png" width="25%" height="25%">
</p>

## layer 3 - CONVOLUÇÃO 2
<p align="center">
<img title="Mapa Característico 0" alt="Alt text" src="images/conv0_layer3.png" width="20%" height="20%">
<img title="Mapa Característico 0" alt="Alt text" src="images/conv1_layer3.png" width="20%" height="20%">
<img title="Mapa Característico 0" alt="Alt text" src="images/conv2_layer3.png" width="20%" height="20%">
<img title="Mapa Característico 0" alt="Alt text" src="images/conv3_layer3.png" width="20%" height="20%">
</p>

## layer 4 - MAXPOOLING 2
<p align="center">
<img title="Mapa Característico 0 - Maxpooling" alt="Alt text" src="images/maxpooling0_layer4.png" width="20%" height="20%">
<img title="Mapa Característico 0 - Maxpooling" alt="Alt text" src="images/maxpooling1_layer4.png" width="20%" height="20%">
<img title="Mapa Característico 0 - Maxpooling" alt="Alt text" src="images/maxpooling2_layer4.png" width="20%" height="20%">
<img title="Mapa Característico 0 - Maxpooling" alt="Alt text" src="images/maxpooling3_layer4.png" width="20%" height="20%">
</p>

## layer 5 - FLATTEN
<p align="center">
<img title="ACHATAMENTO" alt="Alt text" src="images/flatten_layer5.png" width="100%" height="100%">
</p>


## layer 6 - DENSE
<p align="center">
<img title="DENSE" alt="Alt text" src="images/dense_layer6.png"  width="100%" height="100%">
</p>

## Exemplo  Convolução matricial
<p align="center">
<img title="Exemplo de convolução matricial" alt="Alt text" src="images/conv.png">
</p>

Referências

[Topologia dda rede](https://www.youtube.com/watch?v=jDe5BAsT2-Y&ab_channel=Erai)
[Convolutional Neural Network | ep Learning](https://velopersbreach.com/convolution-neural-network-ep-learning/).

[CNN EXPAINER](https://poloclub.github.io/cnn-explainer/#article-convolution).

[ep CNN-SIGN](https://www.baeldung.com/cs/ep-cnn-sign)


[Single-Layer CNN using Verilog](https://santoshsrivatsan24.github.io/ece564_project1.html)


[Verilog Neural Network](https://yycho0108.github.io/CompArchNeuralNet/)


[2D Convolution in Hardware](https://sistenix.com/sobel.html)


[Verilog Project Iias](https://vlsiverify.com/verilog/verilog-project-ias/)

[The Convolutional Filter](https://medium.com/advanced-ep-learning/cnn-operation-with-2-kernels-resulting-in-2-feature-mapsunrstanding-the-convolutional-filter-c4aad26cf32)
