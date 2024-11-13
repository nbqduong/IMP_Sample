#ifndef DATABASE_H
#define DATABASE_H
#include <opencv2/opencv.hpp>
#include <iostream>
#include <qlogging.h>
using namespace cv;

class dataBase{
public:
    static dataBase& getInstance(){static dataBase instance; return instance;}
    void setImage(Mat &image){mImage = image;};
    Mat getImage(){return mImage;};

private:
    Mat mImage;
    dataBase(){};
    dataBase(const dataBase&) = delete;
    dataBase& operator=(const dataBase&) = delete;
};
#endif // DATABASE_H
