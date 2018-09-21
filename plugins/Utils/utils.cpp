#include <QFile>

#include "utils.h"

Utils::Utils() {

}

void Utils::remove(QString path) {
    QFile file(path);
    file.remove();
}
