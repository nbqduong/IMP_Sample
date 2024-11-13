#include "interface.h"

InterFace::InterFace() {
    appPath = QDir::currentPath() + "/";
}

void InterFace::setImage2Filter(QString image)
{
    unique_ptr<filter> t = std::make_unique<filter>();
    if(t->loadImage((image).toStdString())==0){
        qInfo() << "Fail to load image";
    }else{
        currentImage = image;
        currentFilter = std::move(t);
    }
}

void InterFace::applyFilter()
{
    if(currentFilter != nullptr){
        currentFilter->applyFilter();
    }
}

void InterFace::grayFilter(){
    currentFilter = std::make_unique<grayClass>();
    applyFilter();
}

void InterFace::edgeFilter(){
    currentFilter = std::make_unique<edgeClass>();
    applyFilter();
}
