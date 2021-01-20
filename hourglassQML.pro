#include (/home/jim/Qt/qxorm/QxOrm//QxOrm.pri)
TEMPLATE = app

QT += qml quick widgets sql printsupport
CONFIG += c++11

SOURCES += main.cpp \
    algosqlrelationaltablemodel.cpp \
    algosqltablemodel.cpp \
    email.cpp \
    smtp.cpp \
    simpledialer.cpp \
    pdfgenerator.cpp \
    algosqlquerymodel.cpp

# INCLUDEPATH += /home/jim/Qt/qxorm/QxOrm/include/
# INCLUDEPATH += /home/jim/workspace/hourglassqxee/include/
# INCLUDEPATH += /home/jim/workspace/hourglassqxee/custom/include/
# INCLUDEPATH += /home/jim/workspace/hourglassqxee/modelview/include/
# INCLUDEPATH += /home/jim/workspace/hourglassqxee/modelview/custom/include/
INCLUDEPATH += /home/jim/workspace/libs/SmtpClient/


# LIBS += -L"/home/jim/workspace/hourglassqxee/bin"
# LIBS += -L"/home/jim/Qt/qxorm/QxOrm/lib"
# LIBS += -L"/home/jim/workspace/hourglassqxee/modelview/bin"
LIBS += -L"/home/jim/workspace/libs/SmtpClient/"

CONFIG(debug, debug|release) {
# LIBS += -lhourglassqxd
# LIBS += -lhourglassqxModeld
# LIBS += -l"QxOrmd"
LIBS += -l"SMTPEmail"
} else {
# LIBS += -lhourglassqx
# LIBS += -lhourglassqxModel
# LIBS += -l"QxOrm"
LIBS += -l"SMTPEmail"
} # CONFIG(debug, debug|release)


RESOURCES += qml.qrc \
    resources.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
#include(deployment.pri)

HEADERS += \
    algosqlrelationaltablemodel.h \
    algosqltablemodel.h \
    email.h \
    smtp.h \
    simpledialer.h \
    pdfgenerator.h \
    algosqlquerymodel.h

##!contains(DEFINES, _QX_NO_PRECOMPILED_HEADER) {
##PRECOMPILED_HEADER = ./include/precompiled.h
##} # !contains(DEFINES, _QX_NO_PRECOMPILED_HEADER)

##HEADERS += ./include/hourglass_precompiled_header.gen.h
##HEADERS += ./include/hourglass_export.gen.h

DISTFILES += \
    README.md

