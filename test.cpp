#include "test.h"

test::test(QObject *parent) : QObject(parent)
{
    QVariantMap testDataRow;
    for(int i=0; i< 5; i++) {
        testDataRow.clear();
        testDataRow["id"] = i;
        testDataRow["channel"] = 0;
        testDataRow["coff_a"] = 0.1;
        testDataRow["coff_b"] = 0.02;
        testDataRow["coff_c"] = 0.003;
        testDataRow["samples"]= 1;
        testDataRow["direction"]= i%2 ? "DOWN" : "UP";
        testDataRow["active"]= i%2 ? 1 : 0;
        testData.append(testDataRow);
        testDataRow.clear();
    }
}

QVariantList test::getTests()
{
    return testData;
}
