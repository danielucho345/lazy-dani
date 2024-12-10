import datetime

now = datetime.datetime.now()


class MyClass:
    """
    Some class
    """

    def __init__(self) -> None:
        self.now = datetime.datetime.now()

        print(self.__class__.__name__, self.now)
        pass

    @property
    def now(self):
        return self._now

    @now.setter
    def now(self, value):
        self._now = value

    @now.deleter
    def now(self):
        del self._now

    @now.getter
    def now(self):
        return self._now


MyClass()


def sumfun(a: int, b: int) -> int:
    return a + b


sumfun(1, "2")
# TODO: asdfasd
