#include "gtest/gtest.h"
#include "math_operations.h"

TEST(AdditionTests, PositiveNumbers)
{
    EXPECT_EQ(add(1, 2), 3);
    EXPECT_EQ(add(100, 200), 300);
}

TEST(AdditionTests, NegativeNumbers)
{
    EXPECT_EQ(add(-1, -2), -3);
    EXPECT_EQ(add(-100, 50), -50);
}

TEST(AdditionTests, Zero)
{
    EXPECT_EQ(add(0, 0), 0);
    EXPECT_EQ(add(0, 5), 5);
}

// Edge case: large values (may overflow int on some systems)
TEST(AdditionTests, LargeValues)
{
    EXPECT_EQ(add(1000000, 2000000), 3000000);
}
