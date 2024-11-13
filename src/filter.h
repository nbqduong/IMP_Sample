#ifndef FILTER_H
#define FILTER_H
#include <opencv2/opencv.hpp>
#include <iostream>
#include <qlogging.h>
#include "database.h"
using namespace cv;

class filter
{

public:
    virtual void applyFilter(){};
    bool loadImage(std::string image);
    virtual ~filter(){};
protected:

};


class grayClass : public filter
{
public:
    void applyFilter() override;
    ~grayClass(){};
};


class edgeClass : public filter
{
public:
    void applyFilter() override;
    ~edgeClass(){};
};


#endif // FILTER_H
