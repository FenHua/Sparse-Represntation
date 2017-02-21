%演示稀疏算法应用于人脸识别
clc;
clear all;
close all;
addpath(genpath('spams-matlab'));% 添加当前路径下的所有子目录
isLoading=0;
if isLoading
    dataset='Yale';
    fileExt='png';
    datasetPath=['data/',dataset];
    imgDataDir=dir([datasetPath,'*.',fileExt]);
    imgSide=32;
    percentTraining=0.2;
    normalization=true;
    fprintf('Loading and Sperating training and testing samples.....\n');
    [trainLabel,testLabel,trainSample,testSample,numClass]=getTrainTestData(datasetPath,fileExt,imgSide,percentTraining,normalization);
    Train.X=trainSample;
    Train.y=trainLabel;
    Test.X=testSample;
    Test.y=testLabel;
    Nt=size(Test.y,2);% the number of testing samples
else
    load trainData.mat;
    load testData.mat;
    Nt=size(Test.y,2);
end
% run different methods for classification
%1-NN
% % ID1=knnclassify(Test.X',Train.X',Train.y);
% % correctSample=sum(ID1==Test.y');
% % accuracy(1)=correctSample/Nt;
% % fprintf('Nt-Accuracy=%f%%(%d of %d)\n',accuracy(1)*100,correctSample,Nt);
%Sparse Representation Classifier(SRC)
[ID2,relative_error]=src(Train,Test,'omp');
correctSample=sum(ID2==Test.y);
accuracy(2)=correctSample/Nt;
fprintf('SRC(OMP Solver)-Accuracy=%f%%(%d of %d)\n',accuracy(2)*100,correctSample,Nt);
[ID3,relative_error]=src(Train,Test,'apg');
correctSample=sum(ID3==Test.y);
accuracy(3)=correctSample/Nt;
fprintf('SRC(APG Solver)-Accuracy=%f%%(%d of %d)\n',accuracy(3)*100,correctSample,Nt);
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    