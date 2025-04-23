from robot.api.deco import keyword
from selenium.webdriver.remote.webdriver import WebDriver
from selenium.webdriver.remote.webelement import WebElement
from SeleniumLibrary import SeleniumLibrary


class CustomSeleniumLibrary:
    """
    Custom Selenium library using SeleniumLibrary.
    """

    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    def __init__(self):
        """
        Constructor
        """
        self.seleniumlib = SeleniumLibrary()

    @keyword("Get Element Within")
    def get_element_within(self, parent_element: WebElement, locator: str) -> WebElement:
        """
        Finds a single element within a parent WebElement using the provided locator.

        Args:
            parent_element: The parent WebElement to search within.
            locator: The locator for the child element (e.g., "xpath=./div", "css=.child").
                     The locator should be relative to the parent element.

        Returns:
            The found WebElement.

        Raises:
            WebDriverException: If the element is not found.
        """
        return parent_element.find_element(*self.seleniumlib._parse_locator(locator))

    @keyword("Get Elements Within")
    def get_elements_within(self, parent_element: WebElement, locator: str) -> list[WebElement]:
        """
        Finds multiple elements within a parent WebElement using the provided locator.

        Args:
            parent_element: The parent WebElement to search within.
            locator: The locator for the child elements (e.g., "xpath=./div", "css=.children").
                     The locator should be relative to the parent element.

        Returns:
            A list of found WebElements.

        Raises:
            WebDriverException: If the elements are not found.
        """
        return parent_element.find_elements(*self.seleniumlib._parse_locator(locator))

    @keyword("Wait And Get Element Within")
    def wait_and_get_element_within(
        self,
        parent_element: WebElement,
        locator: str,
        timeout: float = 5.0,
        error: str = None,
    ) -> WebElement:
        """
        Waits until a single element appears within a parent WebElement and returns it.

        Args:
            parent_element: The parent WebElement to search within.
            locator: The locator for the child element.
            timeout: Maximum time to wait in seconds.
            error: Custom error message to use if the element is not found within the timeout.

        Returns:
            The found WebElement.

        Raises:
            WebDriverException: If the element is not found within the timeout.
        """
        driver: WebDriver = self.seleniumlib._current_browser()
        message = (
            error
            if error
            else f"Element '{locator}' not found within parent element within {timeout} seconds"
        )

        def is_element_present(_):
            try:
                return parent_element.find_element(*self.seleniumlib._parse_locator(locator))
            except Exception:  # Catch any exception during the element search
                return False

        self.seleniumlib.wait_until_condition(is_element_present, message, timeout)
        return parent_element.find_element(*self.seleniumlib._parse_locator(locator))

    @keyword("Wait And Get Elements Within")
    def wait_and_get_elements_within(
        self,
        parent_element: WebElement,
        locator: str,
        timeout: float = 5.0,
        error: str = None,
    ) -> list[WebElement]:
        """
        Waits until elements appear within a parent WebElement and returns them.

        Args:
            parent_element: The parent WebElement to search within.
            locator: The locator for the child elements.
            timeout: Maximum time to wait in seconds.
            error: Custom error message if the elements are not found within the timeout.

        Returns:
            A list of found WebElements.

        Raises:
            WebDriverException: If the elements are not found within the timeout.
        """
        driver: WebDriver = self.seleniumlib._current_browser()
        message = (
            error
            if error
            else f"Elements '{locator}' not found within parent element within {timeout} seconds"
        )

        def are_elements_present(_):
            try:
                elements = parent_element.find_elements(*self.seleniumlib._parse_locator(locator))
                return len(elements) > 0  # Check if the list has any elements
            except Exception:
                return False

        self.seleniumlib.wait_until_condition(are_elements_present, message, timeout)
        return parent_element.find_elements(*self.seleniumlib._parse_locator(locator))
