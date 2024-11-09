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


MyClass()
