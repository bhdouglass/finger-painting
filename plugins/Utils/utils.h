#ifndef UTILS_H
#define UTILS_H

#include <QObject>

class Utils: public QObject {
    Q_OBJECT

public:
    Utils();
    ~Utils() = default;

    Q_INVOKABLE void remove(QString path);
};

#endif
