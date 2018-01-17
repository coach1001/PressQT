#ifndef TEST_H
#define TEST_H

#include <QObject>
#include <QVariantMap>
#include <QVariantList>

class test : public QObject
{
    Q_OBJECT
public:
    explicit test(QObject *parent = nullptr);
    Q_INVOKABLE QVariantList getTests();

signals:

public slots:

private:
    QVariantList testData;
    QVariantList headerData;
};

#endif // TEST_H
