#include "filter.h"



bool filter::loadImage(std::string image)
{

    Mat mImage = imread(image);

    if ( mImage.empty() )
    {
        return 0;
    }
    dataBase::getInstance().setImage(mImage);
    return 1;
}

void grayClass::applyFilter()
{
    cv::Mat gray_image;
    cv::cvtColor(dataBase::getInstance().getImage(), gray_image, cv::COLOR_BGR2GRAY);
    imwrite("grayscale_image.jpg", gray_image);

}

void edgeClass::applyFilter()
{
    cv::Mat gray_image;
    cv::cvtColor(dataBase::getInstance().getImage(), gray_image, cv::COLOR_BGR2GRAY);


    // Apply Gaussian Blur to reduce noise and improve edge detection
    cv::Mat blurred_image;
    cv::GaussianBlur(gray_image, blurred_image, cv::Size(5, 5), 1.5, 1.5);

    // Perform Canny edge detection
    cv::Mat edges;
    double lower_threshold = 50;
    double upper_threshold = 150;
    cv::Canny(blurred_image, edges, lower_threshold, upper_threshold);
    imwrite("edge_image.jpg", edges);
}
